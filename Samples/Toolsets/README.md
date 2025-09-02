[![Static Badge](https://img.shields.io/badge/Portugu%C3%AAs-(ptBR)-green)](https://github.com/Code4Delphi/ia-na-pratica/tree/master/Samples/Toolsets#%EF%B8%8F-toolsets-conjuntos-de-ferramentas)
[![Static Badge](https://img.shields.io/badge/English-(en)-red)](https://github.com/Code4Delphi/ia-na-pratica/tree/master/Samples/Toolsets#%EF%B8%8F-toolsets)

# 🛠️ Toolsets (conjuntos de ferramentas)
- Fine-Grained AI Function Control (Controle de função de IA de granulação fina)
- Com Toolsets, você pode **ensinar o LLM a interagir com sua aplicação**, mantendo a comunicação leve, relevante e preparada para o futuro
- **Agrupe várias ferramentas** em um único componente ou objeto
- Pense em Toolsets como um **MCP Server nativo integrado ao seu aplicativo**


## 🚀 ToolSets predefinidos no TMS AI Studio

O TMS AI Studio já vem com diversos ToolSets prontos para uso, que cobrem cenários comuns e permitem que a IA interaja com seu aplicativo de forma controlada e segura. Confira alguns deles:

1️⃣ Geração de Logs - `TTMSFNCCloudAILogger` <br/>
Fornece à IA acesso às mensagens de saída, seja no console, em caixas de mensagem ou em arquivos de log.

2️⃣ Sistema de Arquivos - `TTMSFNCCloudAIFileSystem` <br/>
Permite que a IA interaja com o sistema de arquivos local de maneira estruturada e restrita.

3️⃣ Manipulação de Dados - `TTMSFNCCloudAIDataSet` <br/>
Expõe a funcionalidade TDataSet do Delphi, possibilitando consultas e manipulação de registros de banco de dados.

4️⃣ Integração com E-mail - `TTMSFNCCloudAIEmail` <br/>
Oferece à IA acesso ao envio e recuperação de e-mails via POP3/SMTP.


## ✨ Crie seus próprios ToolSets

E se você quiser ir além do que já está disponível, pode criar seu próprio conjunto de ferramentas herdando de `TTMSFNCCloudAIToolSet` e sobrescrevendo o método `DefineTools`.
Assim, você adiciona exatamente os recursos que deseja agrupar e expor para a IA.

👉 Com essa combinação de ToolSets prontos e flexibilidade para criar novos, o TMS AI Studio se adapta a diferentes cenários, tornando sua aplicação muito mais poderosa e inteligente.


## 🔗 Links
- [▶️Vídeo de demonstração Toolsets](https://www.youtube.com/watch?v=Ywd3OzgETyw&list=PLLHSz4dOnnN237tIxJI10E5cy1dgXJxgP)
- [📰Post Oficial](https://www.tmssoftware.com/site/blog.asp?post=2382)

---

<br/>

[![Static Badge](https://img.shields.io/badge/English-(en)-red)](https://github.com/Code4Delphi/ia-na-pratica/tree/master/Samples/Toolsets#%EF%B8%8F-toolsets)
# 🛠️ Toolsets
- Fine-Grained AI Function Control
- With Toolsets, you can teach LLM how to interact with your application, keeping communication lightweight, relevant, and future-proof.
- Bundle multiple tools into a single component or object.
- Think of Toolsets as a native MCP Server integrated into your application.

## 🚀 Predefined ToolSets in TMS AI Studio

TMS AI Studio comes with several ready-to-use ToolSets that cover common scenarios and allow AI to interact with your application in a controlled and secure manner. Check out some of them:

1️⃣ Log Generation - `TTMSFNCCloudAILogger` <br/>
Provides AI access to output messages, whether in the console, message boxes, or log files.

2️⃣ File System - `TTMSFNCCloudAIFileSystem` <br/>
Allows AI to interact with the local file system in a structured and restricted manner.

3️⃣ Data Manipulation - `TTMSFNCCloudAIDataSet` <br/>
Exposes Delphi's TDataSet functionality, enabling queries and manipulation of database records.

4️⃣ Email Integration - `TTMSFNCCloudAIEmail` <br/>
Gives AI access to sending and retrieving emails via POP3/SMTP.

## ✨ Create Your Own ToolSets

And if you want to go beyond what's already available, you can create your own toolset by inheriting from `TTMSFNCCloudAIToolSet` and overriding the `DefineTools` method.
This way, you add exactly the features you want to bundle and expose to AI.

👉 With this combination of ready-made ToolSets and the flexibility to create new ones, TMS AI Studio adapts to different scenarios, making your application much more powerful and intelligent.

## 🔗 Links
- [▶️Toolsets Demo Video](https://www.youtube.com/watch?v=Ywd3OzgETyw&list=PLLHSz4dOnnN237tIxJI10E5cy1dgXJxgP)
- [📰Official Post](https://www.tmssoftware.com/site/blog.asp?post=2382)
