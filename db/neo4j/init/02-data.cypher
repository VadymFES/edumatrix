// Створення концепцій (вузлів) для теми "Квадратні рівняння"
CREATE (c001:Concept {
    id: "C001",
    name: "Визначення квадратного рівняння",
    description: "Рівняння виду ax² + bx + c = 0, де a ≠ 0",
    difficulty: 1,
    importance: 5,
    topic: "Квадратні рівняння"
});

CREATE (c002:Concept {
    id: "C002",
    name: "Стандартна форма квадратного рівняння",
    description: "Запис квадратного рівняння у вигляді ax² + bx + c = 0",
    difficulty: 1,
    importance: 4,
    topic: "Квадратні рівняння"
});

// Додайте інші концепції з графа знань...

// Встановлення зв'язків між концепціями
MATCH (c001:Concept {id: "C001"}), (c002:Concept {id: "C002"})
CREATE (c002)-[:REQUIRES]->(c001);

// Додайте інші залежності відповідно до графа знань...

// Створення навчальних матеріалів
CREATE (m001:Material {
    id: "M001",
    title: "Що таке квадратне рівняння",
    content_type: "text",
    content: "Квадратне рівняння — це алгебраїчне рівняння...",
    difficulty: 1
});

// Прив'язка матеріалів до концепцій
MATCH (c:Concept {id: "C001"}), (m:Material {id: "M001"})
CREATE (c)-[:HAS_MATERIAL]->(m);

// Створення завдань
CREATE (t001:Task {
    id: "T001",
    question: "Яке з наступних рівнянь є квадратним?",
    task_type: "single_choice",
    difficulty: 1,
    options: ["x + 5 = 0", "x² - 9 = 0", "x³ + x = 1", "2x - 7 = 0"],
    correct_answer: "x² - 9 = 0",
    explanation: "Квадратне рівняння має загальний вигляд ax² + bx + c = 0, де a ≠ 0. У даному випадку a = 1, b = 0, c = -9."
});

// Прив'язка завдань до концепцій
MATCH (c:Concept {id: "C001"}), (t:Task {id: "T001"})
CREATE (c)-[:HAS_TASK]->(t);