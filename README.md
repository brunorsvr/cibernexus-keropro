# 🛠️ KeroPro

O **KeroPro** é um aplicativo mobile focado em conectar pessoas que precisam de serviços (Clientes) a profissionais qualificados (Prestadores de Serviço), tudo dentro de uma única plataforma ágil e segura.

## 📱 Sobre o Projeto

O KeroPro utiliza o modelo "Dual-Sided Marketplace" (semelhante a Uber e Airbnb), onde as duas pontas do negócio (quem contrata e quem é contratado) utilizam o mesmo aplicativo. O sistema possui um motor de roteamento inteligente que identifica o perfil do usuário no momento do login e o direciona para a interface adequada às suas necessidades.

## 🚀 Funcionalidades Implementadas (Até o momento)

- [x] **Interface Base:** Telas de Login e Cadastro com validação de dados e feedback visual em tempo real (SnackBars).
- [x] **Autenticação Segura:** Integração com **Firebase Authentication** para criação de contas via e-mail e senha (com travas de segurança contra senhas curtas e e-mails duplicados).
- [x] **Banco de Dados em Nuvem:** Integração com **Cloud Firestore (NoSQL)**.
    - Salva o perfil básico para todos os usuários (Nome, E-mail, Tipo de Usuário).
    - Captura e salva dados estendidos dinamicamente apenas para Profissionais (Profissão, Telefone).
- [x] **Login Inteligente (Roteamento Dinâmico):** Leitura do banco de dados no momento do login. O sistema avalia o campo `tipoUsuario` para direcionar a navegação:
    - `cliente` ➡️ Tela de Busca de Serviços (Em construção)
    - `prestador` ➡️ Painel de Oportunidades (Em construção)
- [x] **Resiliência e UX:** Tratamento de erros assíncronos (`try/catch`), limpeza de espaços invisíveis (`.trim()`) e prevenção de "falsos positivos" de falhas na leitura do banco.

## 💻 Tecnologias e Ferramentas

- **Front-end:** Flutter & Dart
- **Back-end as a Service (BaaS):** Firebase (Google)
- **Autenticação:** Firebase Auth
- **Banco de Dados:** Cloud Firestore (`cloud_firestore` package)

## 📂 Estrutura de Telas (Views)

- `tela_login.dart`: Ponto de entrada, autenticação e catraca de redirecionamento.
- `tela_cadastro.dart`: Formulário dinâmico de registro e gravação no Firestore.
- `tela_clientes.dart`: Ambiente exclusivo para contratantes.
- `tela_profissional.dart`: Painel de visualização de demandas (Card view).

---
*Projeto em desenvolvimento ativo.*
