#!/bin/bash

##############################################################################
# healthcheck_sut.sh - Script para verificar la salud del SUT
# 
# Uso: ./setup/healthcheck_sut.sh [--verbose] [--deep]
# Opciones:
#   --verbose    Mostrar todos los detalles
#   --deep       Realizar checks profundos (tests básicos)
#   -h, --help   Mostrar esta ayuda
##############################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables de control
VERBOSE=false
DEEP=false
PASSED=0
FAILED=0
WARNINGS=0

# Funciones
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
    PASSED=$((PASSED + 1))
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
    FAILED=$((FAILED + 1))
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
    WARNINGS=$((WARNINGS + 1))
}

print_info() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}→ $1${NC}"
    fi
}

show_help() {
    grep "^#" "$0" | grep -v "^#!/bin/bash" | sed 's/^#//' | head -20
}

check_docker() {
    print_info "Verificando Docker..."
    if command -v docker &> /dev/null; then
        print_success "Docker instalado"
        if docker ps > /dev/null 2>&1; then
            print_success "Docker daemon respondiendo"
        else
            print_error "Docker daemon no responde"
        fi
    else
        print_error "Docker no está instalado"
    fi
}

check_containers() {
    print_info "Verificando contenedores..."
    cd "$PROJECT_ROOT"
    
    # PostgreSQL
    if docker ps --filter "name=pgdb" --filter "status=running" --quiet 2>/dev/null | grep -q .; then
        print_success "PostgreSQL container ejecutándose"
    else
        print_warning "PostgreSQL container no está ejecutándose"
    fi
    
    # FastAPI app (si está en docker-compose)
    if docker-compose ps app 2>/dev/null | grep -q "Up"; then
        print_success "FastAPI app container ejecutándose"
    else
        print_info "FastAPI app no está en contenedor o no está arriba"
    fi
}

check_postgresql() {
    print_info "Verificando PostgreSQL..."
    
    if docker ps --filter "name=pgdb" --filter "status=running" --quiet 2>/dev/null | grep -q .; then
        if docker-compose exec -T db pg_isready -U postgres > /dev/null 2>&1; then
            print_success "PostgreSQL respondiendo"
            
            # Verificar base de datos
            if docker-compose exec -T db psql -U postgres -d rwdb -c "SELECT 1" > /dev/null 2>&1; then
                print_success "Base de datos 'rwdb' accesible"
            else
                print_warning "No se puede conectar a BD 'rwdb'"
            fi
            
            # Verificar tablas
            table_count=$(docker-compose exec -T db psql -U postgres -d rwdb -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public'" 2>/dev/null || echo "0")
            if [ "$table_count" -gt 0 ]; then
                print_success "Base de datos contiene $table_count tablas"
            else
                print_warning "Base de datos vacía (ejecutar migraciones)"
            fi
        else
            print_error "PostgreSQL no responde a conexión"
        fi
    else
        print_error "PostgreSQL container no ejecutándose"
    fi
}

check_api() {
    print_info "Verificando API FastAPI..."
    
    if curl -s http://localhost:8000/docs > /dev/null 2>&1; then
        print_success "API respondiendo en http://localhost:8000"
        
        # Verificar Swagger
        if curl -s http://localhost:8000/docs | grep -q "swagger"; then
            print_success "Swagger UI disponible"
        else
            print_warning "Swagger UI no disponible"
        fi
        
        # Verificar health endpoint (si existe)
        if curl -s http://localhost:8000/api/health > /dev/null 2>&1; then
            print_success "Health endpoint funcionando"
        else
            print_info "Health endpoint no disponible (esperado)"
        fi
    else
        print_warning "API no respondiendo en http://localhost:8000"
        print_info "¿Fue iniciada con ./setup/run_sut.sh?"
    fi
}

check_network() {
    print_info "Verificando conectividad de red..."
    
    # Verificar que Puerto 8000 está escuchando
    if netstat -tuln 2>/dev/null | grep -q ":8000 " || lsof -i :8000 2>/dev/null | grep -q LISTEN; then
        print_success "Puerto 8000 escuchando"
    else
        print_warning "Puerto 8000 no está escuchando"
    fi
    
    # Verificar Puerto 5432
    if netstat -tuln 2>/dev/null | grep -q ":5432 " || lsof -i :5432 2>/dev/null | grep -q LISTEN; then
        print_success "Puerto 5432 (PostgreSQL) escuchando"
    else
        print_warning "Puerto 5432 no está escuchando"
    fi
}

check_logs() {
    print_info "Verificando logs..."
    cd "$PROJECT_ROOT"
    
    # Verificar errores en logs de PostgreSQL
    if docker-compose logs db 2>/dev/null | grep -i "error" | head -1 > /dev/null 2>&1; then
        print_warning "Se encontraron errores en logs de PostgreSQL"
    else
        print_success "Sin errores en logs de PostgreSQL"
    fi
    
    # Verificar errores en logs de app
    if [ -f "app.log" ]; then
        if grep -i "error" app.log 2>/dev/null | head -1 > /dev/null 2>&1; then
            print_warning "Se encontraron errores en logs de app"
        else
            print_success "Sin errores en logs de app"
        fi
    fi
}

run_basic_tests() {
    if [ "$DEEP" = true ]; then
        print_info "Ejecutando tests básicos..."
        cd "$PROJECT_ROOT"
        
        if command -v poetry &> /dev/null; then
            # Solo ejecutar un test rápido
            if poetry run pytest tests/test_schemas/test_rw_model.py -v --tb=short > /dev/null 2>&1; then
                print_success "Tests básicos pasando"
            else
                print_warning "Algunos tests básicos fallando"
            fi
        else
            print_info "Poetry no disponible para tests"
        fi
    fi
}

show_summary() {
    echo ""
    print_header "Resumen de Health Check"
    
    total=$((PASSED + FAILED + WARNINGS))
    echo ""
    echo -e "${GREEN}Pasadas: $PASSED${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}Advertencias: $WARNINGS${NC}"
    fi
    if [ $FAILED -gt 0 ]; then
        echo -e "${RED}Fallidas: $FAILED${NC}"
    fi
    
    echo ""
    
    if [ $FAILED -eq 0 ]; then
        if [ $WARNINGS -eq 0 ]; then
            echo -e "${GREEN}✓ ESTADO: SALUDABLE${NC}"
            return 0
        else
            echo -e "${YELLOW}⚠ ESTADO: PARCIALMENTE SALUDABLE (con advertencias)${NC}"
            return 0
        fi
    else
        echo -e "${RED}✗ ESTADO: CON PROBLEMAS${NC}"
        return 1
    fi
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose)
            VERBOSE=true
            shift
            ;;
        --deep)
            DEEP=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Opción desconocida: $1"
            show_help
            exit 1
            ;;
    esac
done

# Ejecución principal
print_header "FastAPI RealWorld SUT - Health Check"

check_docker
check_containers
check_postgresql
check_api
check_network
check_logs
run_basic_tests

show_summary
exit_code=$?

echo ""
echo -e "${BLUE}Para más información:${NC}"
echo "  Logs API:        docker-compose logs app"
echo "  Logs BD:         docker-compose logs db"
echo "  Estado actual:   docker-compose ps"
echo "  Re-iniciar:      ./setup/run_sut.sh"
echo ""

exit $exit_code
