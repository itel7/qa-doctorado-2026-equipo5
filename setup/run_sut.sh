#!/bin/bash

##############################################################################
# run_sut.sh - Script para iniciar el SUT (FastAPI RealWorld)
# 
# Uso: ./setup/run_sut.sh [--rebuild]
# Opciones:
#   --rebuild    Reconstruir imágenes Docker
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
NC='\033[0m' # No Color

# Funciones
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

show_help() {
    grep "^#" "$0" | grep -v "^#!/bin/bash" | sed 's/^#//' | head -20
}

# Parse arguments
REBUILD=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --rebuild)
            REBUILD=true
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

# Main execution
print_header "Iniciando FastAPI RealWorld SUT"

cd "$PROJECT_ROOT"

# Verificar Docker
print_info "Verificando Docker..."
if ! command -v docker &> /dev/null; then
    print_error "Docker no está instalado"
    exit 1
fi
print_success "Docker encontrado"

# Verificar Docker Compose
print_info "Verificando Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose no está instalado"
    exit 1
fi
print_success "Docker Compose encontrado"

# Verificar archivo .env
print_info "Verificando configuración..."
if [ ! -f ".env" ]; then
    print_error "Archivo .env no encontrado"
    print_info "Creando .env desde .env.example..."
    if [ -f ".env.example" ]; then
        cp .env.example .env
        print_success "Archivo .env creado"
    else
        print_info "Creando .env nuevo..."
        cat > .env << 'EOF'
APP_ENV=dev
DATABASE_URL=postgresql://postgres:postgres@db:5432/rwdb
SECRET_KEY=dev-secret-key-change-in-production
POSTGRES_DB=rwdb
POSTGRES_PORT=5432
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
EOF
        print_success "Archivo .env creado"
    fi
fi

# Detener contenedores existentes si hay
print_info "Limpiando contenedores previos..."
docker-compose down --remove-orphans 2>/dev/null || true
print_success "Limpieza completada"

# Rebuild si se solicita
if [ "$REBUILD" = true ]; then
    print_info "Reconstruyendo imágenes Docker..."
    docker-compose build --no-cache
    print_success "Imágenes reconstruidas"
fi

# Iniciar servicios
print_info "Iniciando servicios..."
docker-compose up -d

print_success "Servicios iniciados"

# Esperar a que PostgreSQL esté listo
print_info "Esperando a PostgreSQL..."
max_attempts=30
attempt=1
while [ $attempt -le $max_attempts ]; do
    if docker-compose exec -T db pg_isready -U postgres > /dev/null 2>&1; then
        print_success "PostgreSQL está listo"
        break
    fi
    echo -n "."
    sleep 1
    attempt=$((attempt + 1))
done

if [ $attempt -gt $max_attempts ]; then
    print_error "PostgreSQL no respondió después de 30 segundos"
    exit 1
fi

# Ejecutar migraciones
print_info "Ejecutando migraciones de base de datos..."
if docker-compose exec -T app poetry run alembic upgrade head; then
    print_success "Migraciones completadas"
else
    print_error "Error en migraciones"
    exit 1
fi

# Mostrar información de acceso
print_header "SUT Iniciado Correctamente"
echo ""
echo -e "${GREEN}Servicios ejecutándose:${NC}"
echo "  API:           http://localhost:8000"
echo "  Swagger UI:    http://localhost:8000/docs"
echo "  ReDoc:         http://localhost:8000/redoc"
echo "  PostgreSQL:    localhost:5432"
echo ""
echo -e "${YELLOW}Credenciales por defecto:${NC}"
echo "  Usuario BD:    postgres"
echo "  Contraseña:    postgres"
echo "  Base de datos: rwdb"
echo ""
echo -e "${BLUE}Próximos pasos:${NC}"
echo "  1. Verificar salud:  ./setup/healthcheck_sut.sh"
echo "  2. Ejecutar tests:   poetry run pytest"
echo "  3. Detener:          ./setup/stop_sut.sh"
echo ""

print_success "¡Sistema listo para pruebas!"
