# 🍄 Reino Fúngico — Jogo Plataforma 2D

Um jogo de plataforma 2D desenvolvido em **Godot Engine**, ambientado em um **reino fúngico**, onde cogumelos não são apenas cenário, mas parte central das mecânicas do jogo.

O jogador explora fases, enfrenta inimigos, coleta itens e interage com cogumelos que concedem **buffs, debuffs e checkpoints**.

---

## 🎮 Sobre o Jogo

No Reino Fúngico, a natureza está viva. Cogumelos especiais influenciam o comportamento do personagem, alterando velocidade, controle e sobrevivência.

O jogo conta com:
- Sistema de vidas
- Pontuação (score)
- Coleta de gotas de água
- Inimigos com colisão dinâmica
- Checkpoints visuais baseados em cogumelos
- Tela de Game Over funcional

---

## 🕹️ Controles

| Tecla | Ação |
|------|------|
| ← / → | Mover |
| Espaço | Pular |
| ↓ | Agachar |
| E | Interagir |
| Esc | Pausar |

---

## 🍄 Mecânicas Principais

- **Cogumelos especiais**
  - Salvam checkpoints
  - Aplicam efeitos temporários
- **Inimigos**
  - Podem ser derrotados pulando sobre eles
  - Causam dano ao encostar lateralmente
- **Sistema de vidas**
  - O jogador começa com 3 vidas
- **Checkpoint**
  - Salva progresso da fase
- **Game Over**
  - Exibe score e itens coletados
  - Permite reiniciar ou voltar ao menu

---

## 🛠️ Tecnologias Utilizadas

- 🎮 **Godot Engine (GDScript)**
- 🎨 Pixel Art
- 🔊 Áudio integrado
- 🗂️ Git & GitHub para versionamento

---

## 📁 Estrutura do Projeto (resumida)

res://

├── entities/ 

│ ├── player.tscn 

│ ├── enemy.tscn 

├── scene/ 

│ ├── game_over.tscn

│ └── fases/

├── scripts/

├── sprites/

├── audios/

├── singletones/

│ └── Globals.gd




## 🚀 Como Executar

1. Baixe ou clone o repositório
2. Abra o projeto na **Godot Engine**
3. Execute a cena principal (`F5`)

---

## 📚 Objetivo do Projeto

Este jogo foi desenvolvido com fins **educacionais**, visando:
- Aprendizado de lógica de programação
- Uso de Programação Orientada a Objetos
- Desenvolvimento de jogos 2D
- Criação de um projeto para portfólio

---

## 👤 Autor

Desenvolvido por **Elyan Gomes**  
🎓 Estudante de Informática  
💻 Apaixonado por programação e desenvolvimento de jogos

---

## 📌 Status do Projeto

🟢 Em desenvolvimento  
Novas fases e mecânicas podem ser adicionadas futuramente.

---

🍄 *No Reino Fúngico, até o menor cogumelo pode mudar tudo.*
