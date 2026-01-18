# 🚀 Como Rodar o Projeto Híbrido MAUI + Blazor Web

## 📋 3 Formas de Rodar os Projetos

---

## 1️⃣ Via PowerShell (Recomendado para Windows)

### Navegue até a pasta do projeto:
```powershell
cd D:\CODE\MauiTeste\MauiTeste
```

### Comandos disponíveis:

```powershell
# Rodar projeto Web
.\run.ps1 web

# Rodar projeto MAUI Windows
.\run.ps1 maui

# Build todos os projetos
.\run.ps1 build:all

# Limpar projetos
.\run.ps1 clean

# Restaurar dependências
.\run.ps1 restore

# Ver todos os comandos
.\run.ps1
```

Se a porta 5214 estiver ocupada, o script escolhe outra porta e imprime a URL no terminal.

---

## 2️⃣ Via VSCode Tasks

### Como acessar:

1. Abra o VSCode na pasta do projeto
2. Pressione `Ctrl+Shift+P`
3. Digite: `Tasks: Run Task`
4. Escolha a task:

### Tasks disponíveis:

- **▶️ Web - Run** → Roda o projeto Blazor Web
- **▶️ MAUI Windows - Run** → Roda o projeto MAUI Windows
- **🔨 Build - Web** → Build do projeto Web
- **🔨 Build - MAUI** → Build do projeto MAUI
- **🔨 Build - Todos** → Build de todos os projetos
- **🧹 Clean** → Limpa todos os projetos
- **📦 Restore** → Restaura dependências

Obs: a task **▶️ Web - Run** usa o script e escolhe uma porta livre quando 5214 estiver ocupada.

### Atalho rápido:
- Pressione `Ctrl+Shift+B` para abrir o menu de Build

---

## 3️⃣ Via Comandos dotnet Direto

```powershell
# Rodar Web
dotnet run --project MauiTeste.Web/MauiTeste.Web.csproj

# Build MAUI Windows
dotnet build MauiTeste/MauiTeste.csproj -f net9.0-windows10.0.19041.0

# Executar MAUI Windows (após build)
.\MauiTeste\bin\Debug\net9.0-windows10.0.19041.0\win10-x64\MauiTeste.exe

# Build todos
dotnet build MauiTeste.sln

# Limpar
dotnet clean MauiTeste.sln

# Restaurar
dotnet restore MauiTeste.sln
```

Se precisar de outra porta no Web, use `--urls http://localhost:PORTA`.

---

## 🍎 Para macOS

```bash
cd ~/CODE/MauiTeste/MauiTeste

# Rodar Web
./run.sh web

# Rodar MAUI macOS
./run.sh maui-mac

# Build MAUI iOS
./run.sh maui-ios

# Ver todos os comandos
./run.sh
```

---

## 🐧 Para Linux

```bash
cd ~/CODE/MauiTeste/MauiTeste

# Rodar Web
./run.sh web

# Build MAUI Android
./run.sh maui-android

# Ver todos os comandos
./run.sh
```

---

## ⚠️ Problemas Comuns

### "run.ps1: The term is not recognized"
**Causa:** PowerShell precisa de `.\` antes do comando  
**Solução:** Use `.\run.ps1` em vez de `run.ps1`

### "Execution of scripts is disabled on this system"
**Causa:** Política de execução do PowerShell  
**Solução:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Build falha no MAUI
**Causa:** Workloads do .NET MAUI não instalados  
**Solução:**
```powershell
dotnet workload install maui
```

### Executável MAUI não encontrado
**Causa:** Projeto não foi compilado  
**Solução:**
```powershell
.\run.ps1 build:maui
```

---

## 📦 Estrutura de Pastas

```
MauiTeste/
├── MauiTeste/              # Projeto MAUI (Desktop/Mobile)
├── MauiTeste.Shared/       # Código compartilhado
├── MauiTeste.Web/          # Projeto Web
├── .vscode/                # Configurações VSCode
│   ├── tasks.json          # Tasks simplificadas
│   ├── launch.json         # Debug
│   └── settings.json       # Settings
├── run.ps1                 # Script PowerShell
├── run.sh                  # Script Bash (Mac/Linux)
└── run.bat                 # Script CMD (Windows)
```

---

## 🎯 Próximo Passo

**Teste agora:**

```powershell
cd D:\CODE\MauiTeste\MauiTeste
.\run.ps1 web
```

O projeto Web abrirá no navegador em: `http://localhost:5000` ou similar.

---

**Última atualização:** 2025-12-30
