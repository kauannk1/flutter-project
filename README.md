# 📱 Portal do Aluno - (Versão Flutter)

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Material Design](https://img.shields.io/badge/Material%20Design%203-757575?style=for-the-badge&logo=material-design&logoColor=white)

> **Status do Projeto:** 🚧 Em Desenvolvimento 🚧

## ✒️ Sobre o Projeto

Este é um aplicativo multiplataforma desenvolvido como projeto prático para a faculdade. O objetivo é criar um portal acadêmico funcional para alunos e professores.

O projeto já está em um estágio intermediário, com integração completa com o **Firebase** para autenticação de usuários e armazenamento de dados em tempo real no Firestore. No entanto, o aplicativo ainda está incompleto e em constante desenvolvimento.

---

### **Autor**

* **Nome:** Kauan Rafael Silva Sena
* **RA:** 2840482523040
* **Curso:** Análise e Desenvolvimento de Sistemas
* **Semestre:** 4º Semestre - Noturno

---

## ✨ Funcionalidades Implementadas

### Gerais
- [x] **Autenticação de Usuários:**
    - [x] Login com E-mail e Senha.
    - [x] Cadastro inteligente de Alunos e Professores.
    - [x] Funcionalidade de "Recuperar Senha".
- [x] **Sistema de Permissões:** Diferenciação de interface e regras de segurança para os papéis de `aluno` e `professor`.
- [x] **Navegação Híbrida:** Uso de `BottomNavigationBar` para acesso rápido e `NavigationDrawer` (Menu Lateral) para demais seções.
- [x] **Tema Escuro (Dark Mode):** Seletor de tema com opções Claro, Escuro e Padrão do Sistema.
- [x] **Gerenciamento de Perfil:** O usuário pode trocar sua foto de perfil.

### Funcionalidades do Aluno
- [x] **Visualização de Horário:** Tela dinâmica que busca e exibe o horário de aulas do semestre do aluno, com base na sua turma.
- [x] **Visualização de Notas:** Tela dinâmica com design de cards que exibe as notas e faltas do aluno.

### Funcionalidades do Professor
- [x] **Lançamento de Notas:** Tela para selecionar um aluno e lançar/editar suas notas. A tela exibe **apenas** as matérias que o professor logado leciona para aquele aluno.
- [x] **Gerenciamento de Avisos:** Tela para criar e visualizar avisos gerais para os alunos.

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Dart
* **Framework:** Flutter
* **Backend:**
    * **Firebase Authentication:** Para gerenciamento de contas.
    * **Cloud Firestore:** Como banco de dados NoSQL em tempo real.
* **Gerenciamento de Estado:** Provider
* **Armazenamento de Mídia:** Cloudinary

---

## 🚀 Como Executar o Projeto

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/kauannk1/flutter-project.git
    ```
2.  **Entre na pasta do projeto:**
    ```sh
    cd flutter-project
    ```
3.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```
4.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```
> **Nota:** É necessário ter uma configuração do Firebase (`firebase_options.dart`) válida para que o aplicativo se conecte ao backend.

---

## 🔮 Próximos Passos

O projeto ainda está evoluindo. As próximas funcionalidades a serem implementadas incluem:

- [ ] Tornar a **Aba de Calendário** dinâmica, exibindo eventos do Firestore.
- [ ] Implementar a funcionalidade para **Professores adicionarem Atividades**.
- [ ] Concluir o preenchimento das telas com conteúdo estático, como a **Aba "Meu Curso"**.
- [ ] Adicionar um sistema de matrículas mais flexível, gerenciado por um Coordenador.
