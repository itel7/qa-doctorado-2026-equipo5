#!/bin/bash

##############################################################################
# stop_sut.sh - Script para detener el SUT (FastAPI RealWorld)
# 
# Uso: ./setup/stop_sut.sh [--remove] [--volumes]
# Opciones:
#   --remove      Remover contenedores después de detener
#   --volumes     Remover volúmenes (CUIDADO: borra datos)
#   -h, --help    Mostrar esta ayuda
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

print_warning() {
    echo -e "${RED}⚠ $1${NC}"
}

show_help() {
    grep "^#" "$0" | grep -v "^#!/bin/bash" | sed 's/^#//' | head -20
}

# Parse arguments
REMOVE=false
REMOVE_VOLUMES=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --remove)
            REMOVE=true
            shift
            ;;
        --volumes)
            REMOVE_VOLUMES=true
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

print_header "Deteniendo FastAPI RealWorld SUT"

cd "$PROJECT_ROOT"

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose no está instalado"
    exit 1
fi

# Advertencia si se van a remover volúmenes
if [ "$REMOVE_VOLUMES" = true ]; then
    print_warning "ADVERTENCIA: Se removerán los volúmenes (datos serán eliminados)"
    read -p "¿Continuar? (s/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        print_info "Operación cancelada"
        exit 0
    fi
fi

# Detener servicios
print_info "Deteniendo contenedores..."
if [ "$REMOVE_VOLUMES" = true ]; then
    docker-compose down -v
    print_success "Contenedores y volúmenes removidos"
elif [ "$REMOVE" = true ]; then
    docker-compose down
    print_success "Contenedores removidos"
else
    docker-compose stop
    print_success "Contenedores detenidos"
fi

# Verificar que se detuvo correctamente
if docker-compose ps --services --filter "status=running" 2>/dev/null | grep -q .; then
    print_warning "Algunos contenedores aún están corriendo"
else
    print_success "Todos los contenedores están detenidos"
fi

echo ""
print_header "Estado Actual"

if [ "$REMOVE" = true ] || [ "$REMOVE_VOLUMES" = true ]; then
    echo -e "${GREEN}Contenedores: Removidos${NC}"
    if [ "$REMOVE_VOLUMES" = true ]; then
        echo -e "${GREEN}Volúmenes: Removidos${NC}"
        echo -e "${YELLOW}Nota: Los datos de PostgreSQL han sido eliminados${NC}"
    fi
else
    echo -e "${YELLOW}Contenedores: Detenidos (no removidos)${NC}"
    echo -e "${YELLOW}Volúmenes: Preservados${NC}"
    echo -e "${BLUE}Próximos pasos:${NC}"
    echo "  - Para iniciar de nuevo:  ./setup/run_sut.sh"
    echo "  - Para remover:           ./setup/stop_sut.sh --remove"
    echo "  - Para limpiar todo:      ./setup/stop_sut.sh --volumes"
fi

echo ""
print_success "¡SUT detenido correctamente!"
