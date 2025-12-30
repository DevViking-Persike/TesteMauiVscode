# TesteMauiVscode 🚀

Projeto híbrido **.NET MAUI + Blazor Web** com código compartilhado, configurado para desenvolvimento em **Windows, macOS e Linux**.

## 📋 Estrutura do Projeto

```
MauiTeste/
├── MauiTeste/              # 🖥️ Aplicativo MAUI (Windows, macOS, Android, iOS)
├── MauiTeste.Shared/       # 🔄 Código Blazor compartilhado
├── MauiTeste.Web/          # 🌐 Aplicação Web Blazor
├── .vscode/                # ⚙️ Configurações VSCode
├── run.ps1                 # 🪟 Script PowerShell (Windows)
├── run.sh                  # 🐧 Script Bash (Mac/Linux)
└── COMO-RODAR.md           # 📖 Guia completo
```

## 🚀 Como Rodar

### Windows (PowerShell):
```powershell
.\run.ps1 web          # Roda projeto Web
.\run.ps1 maui         # Roda projeto MAUI Windows
.\run.ps1 build:all    # Build de todos os projetos
```

### macOS/Linux:
```bash
./run.sh web           # Roda projeto Web
./run.sh maui-mac      # Roda projeto MAUI macOS
./run.sh build:all     # Build de todos os projetos
```

### VSCode Tasks:
1. Pressione `Ctrl+Shift+P`
2. Digite: `Tasks: Run Task`
3. Escolha a task desejada

## 🔧 Requisitos

- ✅ .NET 9 SDK
- ✅ Visual Studio 2022 ou VSCode
- ✅ Workload MAUI: `dotnet workload install maui`

### Windows:
- Workload Windows Desktop

### macOS:
- Xcode
- Workload iOS/macOS

### Linux:
- Android SDK

## 📝 Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `web` | Roda o projeto Blazor Web |
| `maui` | Roda o projeto MAUI (plataforma atual) |
| `maui-windows` | Roda MAUI Windows |
| `maui-mac` | Roda MAUI macOS |
| `maui-android` | Build MAUI Android |
| `build:all` | Build de todos os projetos |
| `clean` | Limpa os projetos |
| `restore` | Restaura dependências |

## 📚 Documentação

- **[COMO-RODAR.md](COMO-RODAR.md)** - Guia detalhado de execução
- **[CHECKLIST.md](CHECKLIST.md)** - Checklist completo do projeto

## 🛠️ Tecnologias

- .NET 9
- .NET MAUI
- Blazor
- C# 12

## 📄 Licença

Este projeto é um teste/exemplo de configuração MAUI + Blazor Web.

## 👨‍💻 Autor

**DevViking-Persike**

---

**Criado em:** 2025-12-30
