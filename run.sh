#!/bin/bash
# Script universal para rodar projeto MAUI + Blazor Web
# Funciona em: Linux, macOS e Windows (Git Bash)

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${YELLOW}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  ${GREEN}MauiTeste - Script de Execução Multiplataforma${NC}         ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Comandos disponíveis:${NC}"
    echo ""
    echo -e "  ${GREEN}./run.sh web${NC}              - Roda o projeto Blazor Web"
    echo -e "  ${GREEN}./run.sh maui${NC}             - Roda o projeto MAUI (plataforma atual)"
    echo -e "  ${GREEN}./run.sh maui-windows${NC}     - Roda MAUI Windows (apenas Windows)"
    echo -e "  ${GREEN}./run.sh maui-mac${NC}         - Roda MAUI macOS (apenas macOS)"
    echo -e "  ${GREEN}./run.sh maui-android${NC}     - Roda MAUI Android"
    echo -e "  ${GREEN}./run.sh maui-ios${NC}         - Roda MAUI iOS (apenas macOS)"
    echo ""
    echo -e "  ${GREEN}./run.sh build:web${NC}        - Build do projeto Web"
    echo -e "  ${GREEN}./run.sh build:maui${NC}       - Build do projeto MAUI"
    echo -e "  ${GREEN}./run.sh build:all${NC}        - Build de todos os projetos"
    echo ""
    echo -e "  ${GREEN}./run.sh clean${NC}            - Limpa todos os projetos"
    echo -e "  ${GREEN}./run.sh restore${NC}          - Restaura dependências"
    echo ""
}

get_free_port() {
    python3 - <<'PY'
import socket
s = socket.socket()
s.bind(("", 0))
print(s.getsockname()[1])
s.close()
PY
}

is_port_in_use() {
    lsof -nP -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1
}

# Detectar sistema operacional
OS_TYPE="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="mac"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="windows"
fi

case "$1" in
    web)
        preferred_port=5214
        port="$preferred_port"
        if is_port_in_use "$port"; then
            port="$(get_free_port)"
        fi
        export ASPNETCORE_ENVIRONMENT="Development"
        echo -e "${GREEN}🚀 Rodando projeto Blazor Web...${NC}"
        echo -e "${YELLOW}🌐 Acesse: http://localhost:${port}${NC}"
        dotnet run --project MauiTeste.Web/MauiTeste.Web.csproj --urls "http://localhost:${port}"
        ;;
    
    maui)
        echo -e "${GREEN}🚀 Rodando projeto MAUI para $OS_TYPE...${NC}"
        if [[ "$OS_TYPE" == "windows" ]]; then
            $0 maui-windows
        elif [[ "$OS_TYPE" == "mac" ]]; then
            $0 maui-mac
        else
            echo -e "${RED}❌ Sistema operacional não suportado para MAUI desktop${NC}"
            echo -e "${YELLOW}💡 Tente: ./run.sh maui-android ou ./run.sh maui-ios${NC}"
        fi
        ;;
    
    maui-windows)
        if [[ "$OS_TYPE" != "windows" ]]; then
            echo -e "${RED}❌ MAUI Windows só pode rodar no Windows${NC}"
            exit 1
        fi
        echo -e "${GREEN}🏗️  Buildando MAUI Windows...${NC}"
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-windows10.0.19041.0
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Build concluído! Iniciando aplicação...${NC}"
            cmd.exe /c start "" "MauiTeste\bin\Debug\net9.0-windows10.0.19041.0\win10-x64\MauiTeste.exe"
        else
            echo -e "${RED}❌ Falha no build${NC}"
        fi
        ;;
    
    maui-mac)
        if [[ "$OS_TYPE" != "mac" ]]; then
            echo -e "${RED}❌ MAUI macOS só pode rodar no macOS${NC}"
            exit 1
        fi
        echo -e "${GREEN}🏗️  Buildando MAUI macOS...${NC}"
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-maccatalyst
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Build concluído! Iniciando aplicação...${NC}"
            APP_PATH=$(find MauiTeste/bin/Debug/net9.0-maccatalyst -maxdepth 3 -type d -name "MauiTeste.app" -print -quit)
            if [[ -n "$APP_PATH" ]]; then
                open "$APP_PATH"
            else
                echo -e "${RED}❌ App não encontrada. Verifique o build em MauiTeste/bin/Debug/net9.0-maccatalyst${NC}"
            fi
        else
            echo -e "${RED}❌ Falha no build${NC}"
        fi
        ;;
    
    maui-android)
        echo -e "${GREEN}🏗️  Buildando MAUI Android...${NC}"
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-android
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Build concluído! Instalando no emulador...${NC}"
            APK=$(find MauiTeste/bin/Debug/net9.0-android -name "*-Signed.apk" | head -1)
            if [[ -n "$APK" ]]; then
                adb install -r "$APK"
                echo -e "${GREEN}✅ Iniciando aplicação...${NC}"
                adb shell monkey -p com.companyname.mauiteste -c android.intent.category.LAUNCHER 1
            else
                echo -e "${RED}❌ APK não encontrado${NC}"
            fi
        else
            echo -e "${RED}❌ Falha no build${NC}"
        fi
        ;;
    
    maui-ios)
        if [[ "$OS_TYPE" != "mac" ]]; then
            echo -e "${RED}❌ MAUI iOS só pode rodar no macOS${NC}"
            exit 1
        fi
        echo -e "${GREEN}🏗️  Buildando e executando MAUI iOS no simulador...${NC}"
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-ios -t:Run
        ;;
    
    build:web)
        echo -e "${GREEN}🏗️  Buildando projeto Web...${NC}"
        dotnet build MauiTeste.Web/MauiTeste.Web.csproj
        ;;
    
    build:maui)
        echo -e "${GREEN}🏗️  Buildando projeto MAUI...${NC}"
        dotnet build MauiTeste/MauiTeste.csproj
        ;;
    
    build:all)
        echo -e "${GREEN}🏗️  Buildando todos os projetos...${NC}"
        dotnet build MauiTeste.sln
        ;;
    
    clean)
        echo -e "${YELLOW}🧹 Limpando projetos...${NC}"
        dotnet clean MauiTeste.sln
        echo -e "${GREEN}✅ Limpeza concluída${NC}"
        ;;
    
    restore)
        echo -e "${BLUE}📦 Restaurando dependências...${NC}"
        dotnet restore MauiTeste.sln
        echo -e "${GREEN}✅ Dependências restauradas${NC}"
        ;;
    
    *)
        show_help
        ;;
esac
