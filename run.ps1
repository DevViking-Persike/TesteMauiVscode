# Script PowerShell para Windows
# MauiTeste - Projeto Híbrido MAUI + Blazor Web

param(
    [Parameter(Position=0)]
    [string]$Command
)

function Show-Help {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "║  " -ForegroundColor Yellow -NoNewline
    Write-Host "MauiTeste - Script de Execução PowerShell" -ForegroundColor Green -NoNewline
    Write-Host "              ║" -ForegroundColor Yellow
    Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Comandos disponíveis:" -ForegroundColor Blue
    Write-Host ""
    Write-Host "  .\run.ps1 web" -ForegroundColor Green -NoNewline
    Write-Host "              - Roda o projeto Blazor Web"
    Write-Host "  .\run.ps1 maui" -ForegroundColor Green -NoNewline
    Write-Host "             - Roda o projeto MAUI Windows"
    Write-Host "  .\run.ps1 maui-windows" -ForegroundColor Green -NoNewline
    Write-Host "     - Roda MAUI Windows"
    Write-Host "  .\run.ps1 maui-android" -ForegroundColor Green -NoNewline
    Write-Host "     - Build MAUI Android"
    Write-Host ""
    Write-Host "  .\run.ps1 build:web" -ForegroundColor Green -NoNewline
    Write-Host "        - Build do projeto Web"
    Write-Host "  .\run.ps1 build:maui" -ForegroundColor Green -NoNewline
    Write-Host "       - Build do projeto MAUI"
    Write-Host "  .\run.ps1 build:all" -ForegroundColor Green -NoNewline
    Write-Host "        - Build de todos os projetos"
    Write-Host ""
    Write-Host "  .\run.ps1 clean" -ForegroundColor Green -NoNewline
    Write-Host "            - Limpa todos os projetos"
    Write-Host "  .\run.ps1 restore" -ForegroundColor Green -NoNewline
    Write-Host "          - Restaura dependências"
    Write-Host ""
}

function Get-FreePort {
    $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 0)
    $listener.Start()
    $port = $listener.LocalEndpoint.Port
    $listener.Stop()
    return $port
}

function Test-PortFree {
    param(
        [Parameter(Mandatory=$true)]
        [int]$Port
    )

    try {
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
        $listener.Start()
        $listener.Stop()
        return $true
    } catch {
        return $false
    }
}

switch ($Command) {
    "web" {
        Write-Host ""
        Write-Host "🚀 Rodando projeto Blazor Web..." -ForegroundColor Green
        $preferredPort = 5214
        if (Test-PortFree -Port $preferredPort) {
            $port = $preferredPort
        } else {
            $port = Get-FreePort
        }
        $env:ASPNETCORE_ENVIRONMENT = "Development"
        Write-Host "🌐 Acesse: http://localhost:$port" -ForegroundColor Yellow
        dotnet run --project MauiTeste.Web/MauiTeste.Web.csproj --urls "http://localhost:$port"
    }
    
    "maui" {
        & $PSCommandPath maui-windows
    }
    
    "maui-windows" {
        Write-Host ""
        Write-Host "🏗️  Buildando MAUI Windows..." -ForegroundColor Green
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-windows10.0.19041.0
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Build concluído! Iniciando aplicação..." -ForegroundColor Green
            Start-Process "MauiTeste\bin\Debug\net9.0-windows10.0.19041.0\win10-x64\MauiTeste.exe"
        } else {
            Write-Host "❌ Falha no build" -ForegroundColor Red
        }
    }
    
    "maui-android" {
        Write-Host ""
        Write-Host "🏗️  Buildando MAUI Android..." -ForegroundColor Green
        dotnet build MauiTeste/MauiTeste.csproj -f net9.0-android
        Write-Host "💡 Use Android Studio ou adb para instalar no dispositivo" -ForegroundColor Yellow
    }
    
    "build:web" {
        Write-Host ""
        Write-Host "🏗️  Buildando projeto Web..." -ForegroundColor Green
        dotnet build MauiTeste.Web/MauiTeste.Web.csproj
    }
    
    "build:maui" {
        Write-Host ""
        Write-Host "🏗️  Buildando projeto MAUI..." -ForegroundColor Green
        dotnet build MauiTeste/MauiTeste.csproj
    }
    
    "build:all" {
        Write-Host ""
        Write-Host "🏗️  Buildando todos os projetos..." -ForegroundColor Green
        dotnet build MauiTeste.sln
    }
    
    "clean" {
        Write-Host ""
        Write-Host "🧹 Limpando projetos..." -ForegroundColor Yellow
        dotnet clean MauiTeste.sln
        Write-Host "✅ Limpeza concluída" -ForegroundColor Green
    }
    
    "restore" {
        Write-Host ""
        Write-Host "📦 Restaurando dependências..." -ForegroundColor Blue
        dotnet restore MauiTeste.sln
        Write-Host "✅ Dependências restauradas" -ForegroundColor Green
    }
    
    default {
        Show-Help
    }
}
