# ✅ CHECKLIST - Projeto Híbrido MAUI + Blazor Web

## 📋 Estrutura do Projeto

```
MauiTeste/
├── .vscode/
│   ├── tasks.json           # Tarefas do VSCode (multiplataforma)
│   ├── keybindings.json     # Atalhos de teclado
│   ├── launch.json          # Configurações de debug
│   └── settings.json        # Configurações do workspace
├── MauiTeste/               # 🖥️ Projeto MAUI (Desktop/Mobile)
│   ├── MauiTeste.csproj
│   ├── App.xaml
│   ├── MainPage.xaml
│   ├── MauiProgram.cs
│   ├── Platforms/           # Código específico por plataforma
│   └── Resources/           # Assets (imagens, fonts, etc)
├── MauiTeste.Shared/        # 🔄 Código compartilhado (Blazor)
│   ├── MauiTeste.Shared.csproj
│   ├── Layout/              # Layouts Blazor
│   ├── Pages/               # Páginas Blazor
│   └── Services/            # Serviços compartilhados
├── MauiTeste.Web/           # 🌐 Projeto Web (Blazor Server/WASM)
│   ├── MauiTeste.Web.csproj
│   ├── Program.cs
│   └── Components/          # Componentes Web
├── MauiTeste.sln            # Solução .NET
├── run.sh                   # 🐧 Script Bash (Linux/Mac/Git Bash)
├── run.bat                  # 🪟 Script CMD (Windows)
├── run.ps1                  # ⚡ Script PowerShell (Windows)
├── Makefile                 # 🛠️ Make (opcional)
└── CHECKLIST.md             # 📄 Este arquivo
```

---

## 🚀 Como Rodar o Projeto

### 🪟 Windows

#### PowerShell (Recomendado):
```powershell
cd D:\CODE\MauiTeste\MauiTeste

# Rodar projeto Web
.\run.ps1 web

# Rodar projeto MAUI Windows
.\run.ps1 maui

# Build de todos
.\run.ps1 build:all

# Limpar projetos
.\run.ps1 clean
```

#### CMD (Prompt de Comando):
```cmd
cd D:\CODE\MauiTeste\MauiTeste

# Rodar projeto Web
run.bat web

# Rodar projeto MAUI Windows
run.bat maui

# Build de todos
run.bat build:all
```

#### Git Bash (Windows):
```bash
cd /d/CODE/MauiTeste/MauiTeste

# Rodar projeto Web
./run.sh web

# Rodar projeto MAUI Windows
./run.sh maui-windows

# Build de todos
./run.sh build:all
```

---

### 🍎 macOS

```bash
cd ~/CODE/MauiTeste/MauiTeste

# Rodar projeto Web
./run.sh web

# Rodar projeto MAUI macOS
./run.sh maui-mac

# Build MAUI iOS
./run.sh maui-ios

# Build de todos
./run.sh build:all
```

---

### 🐧 Linux

```bash
cd ~/CODE/MauiTeste/MauiTeste

# Rodar projeto Web
./run.sh web

# Build MAUI Android
./run.sh maui-android

# Build de todos
./run.sh build:all
```

---

### Como usar:
1. Abra o projeto no VSCode: `code D:\CODE\MauiTeste\MauiTeste`
2. Pressione o atalho desejado
3. O projeto será compilado e executado automaticamente

---

## 📝 Todos os Comandos Disponíveis

### Via Scripts (run.sh / run.ps1):

| Comando | Descrição |
|---------|-----------|
| `web` | Roda o projeto Blazor Web |
| `maui` | Roda o projeto MAUI (plataforma atual) |
| `maui-windows` | Roda MAUI Windows (apenas Windows) |
| `maui-mac` | Roda MAUI macOS (apenas macOS) |
| `maui-android` | Build MAUI Android |
| `maui-ios` | Build MAUI iOS (apenas macOS) |
| `build:web` | Build do projeto Web |
| `build:maui` | Build do projeto MAUI |
| `build:all` | Build de todos os projetos |
| `clean` | Limpa todos os projetos |
| `restore` | Restaura dependências NuGet |

### Comandos dotnet diretos:

```bash
# Rodar Web
dotnet run --project MauiTeste.Web/MauiTeste.Web.csproj

# Build MAUI Windows
dotnet build MauiTeste/MauiTeste.csproj -f net9.0-windows10.0.19041.0

# Build MAUI macOS
dotnet build MauiTeste/MauiTeste.csproj -f net9.0-maccatalyst

# Build MAUI Android
dotnet build MauiTeste/MauiTeste.csproj -f net9.0-android

# Build MAUI iOS
dotnet build MauiTeste/MauiTeste.csproj -f net9.0-ios

# Build todos
dotnet build MauiTeste.sln

# Limpar
dotnet clean MauiTeste.sln

# Restaurar
dotnet restore MauiTeste.sln
```

---

## 🔧 Requisitos

### Todos os Sistemas:
- ✅ .NET 9 SDK instalado
- ✅ VSCode (opcional, mas recomendado)

### Windows:
- ✅ Visual Studio 2022 (para desenvolvimento MAUI)
- ✅ Workload: .NET MAUI (`dotnet workload install maui`)
- ✅ Workload: Windows Desktop (`dotnet workload install windows`)

### macOS:
- ✅ Xcode (para iOS/macOS)
- ✅ Workload: .NET MAUI (`dotnet workload install maui`)
- ✅ Workload: iOS (`dotnet workload install ios`)
- ✅ Workload: macOS (`dotnet workload install maccatalyst`)

### Linux:
- ✅ Workload: .NET MAUI (`dotnet workload install maui`)
- ✅ Android SDK (para desenvolvimento Android)

---

## 🐛 Troubleshooting

### Erro: "run.bat: The term is not recognized"
**Solução (PowerShell):** Use `.\run.bat` ou `.\run.ps1` em vez de `run.bat`

### Erro: "Permission denied: ./run.sh"
**Solução (Linux/Mac):** Execute `chmod +x run.sh`

### Erro: Build falha no MAUI
**Solução:** Verifique se os workloads estão instalados:
```bash
dotnet workload list
dotnet workload install maui
```

### Executável MAUI não encontrado
**Solução:** Execute o build primeiro:
```bash
# Windows
.\run.ps1 build:maui

# Mac/Linux
./run.sh build:maui
```

---

## 📦 Estrutura de Build

### Diretórios de Output:

- **Web:** `MauiTeste.Web/bin/Debug/net9.0/`
- **MAUI Windows:** `MauiTeste/bin/Debug/net9.0-windows10.0.19041.0/win10-x64/`
- **MAUI macOS:** `MauiTeste/bin/Debug/net9.0-maccatalyst/`
- **MAUI Android:** `MauiTeste/bin/Debug/net9.0-android/`
- **MAUI iOS:** `MauiTeste/bin/Debug/net9.0-ios/`

---

## 🎯 Próximos Passos

1. ✅ Estrutura do projeto configurada
2. ✅ Scripts multiplataforma criados
3. ✅ Atalhos VSCode configurados
4. ⏳ Testar execução em Windows
5. ⏳ Testar execução em macOS
6. ⏳ Testar execução em Linux
7. ⏳ Configurar CI/CD (GitHub Actions)
8. ⏳ Adicionar testes automatizados

---

## 📚 Recursos Adicionais

- [Documentação .NET MAUI](https://learn.microsoft.com/pt-br/dotnet/maui/)
- [Documentação Blazor](https://learn.microsoft.com/pt-br/aspnet/core/blazor/)
- [VSCode Tasks](https://code.visualstudio.com/docs/editor/tasks)
- [GitHub - Projeto](https://github.com/seu-usuario/MauiTeste)

---

**Criado em:** 2025-12-30  
**Última atualização:** 2025-12-30  
**Versão:** 1.0.0
