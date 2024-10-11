CREATE VIEW alunos_cursos AS
SELECT a.nome AS aluno, d.nome AS disciplina, c.nome AS curso
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
JOIN disciplinas d ON m.disciplina_id = d.id
JOIN cursos c ON d.curso_id = c.id;

CREATE VIEW total_alunos_disciplina AS
SELECT d.nome AS disciplina, COUNT(m.aluno_id) AS total_alunos
FROM disciplinas d
LEFT JOIN matriculas m ON d.id = m.disciplina_id
GROUP BY d.id;


CREATE VIEW alunos_status AS
SELECT a.nome AS aluno, d.nome AS disciplina, m.status AS status_matricula
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
JOIN disciplinas d ON m.disciplina_id = d.id;


CREATE VIEW professores_turmas AS
SELECT p.nome AS professor, d.nome AS disciplina, t.horario AS horario
FROM professores p
JOIN turmas t ON p.id = t.professor_id
JOIN disciplinas d ON t.disciplina_id = d.id;

CREATE VIEW alunos_maiores_20 AS
SELECT nome, data_nascimento
FROM alunos
WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 20;

CREATE VIEW carga_horaria_cursos AS
SELECT c.nome AS curso, COUNT(d.id) AS total_disciplinas, SUM(d.carga_horaria) AS carga_horaria_total
FROM cursos c
JOIN disciplinas d ON c.id = d.curso_id
GROUP BY c.id;


CREATE VIEW professores_especialidades AS
SELECT nome, especialidade
FROM professores;

CREATE VIEW alunos_matriculados_multiplo AS
SELECT a.nome AS aluno, COUNT(m.disciplina_id) AS total_disciplinas
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
GROUP BY a.id
HAVING COUNT(m.disciplina_id) > 1;

CREATE VIEW alunos_disciplinas_concluidas AS
SELECT a.nome AS aluno, COUNT(m.disciplina_id) AS total_concluidas
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Concluído'
GROUP BY a.id;


CREATE VIEW turmas_semestre AS
SELECT *
FROM turmas
WHERE semestre = '2024.1';

CREATE VIEW alunos_matriculas_trancadas AS
SELECT a.nome AS aluno
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
WHERE m.status = 'Trancado';


CREATE VIEW disciplinas_sem_alunos AS
SELECT d.nome AS disciplina
FROM disciplinas d
LEFT JOIN matriculas m ON d.id = m.disciplina_id
WHERE m.aluno_id IS NULL;


CREATE VIEW total_alunos_por_status AS
SELECT m.status AS status_matricula, COUNT(m.aluno_id) AS total_alunos
FROM matriculas m
GROUP BY m.status;


CREATE VIEW total_professores_por_especialidade AS
SELECT especialidade, COUNT(*) AS total_professores
FROM professores
GROUP BY especialidade;

CREATE VIEW alunos_idades AS
SELECT nome, TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade
FROM alunos;

CREATE VIEW alunos_ultimas_matriculas AS
SELECT a.nome AS aluno, MAX(m.data_matricula) AS ultima_matricula
FROM alunos a
JOIN matriculas m ON a.id = m.aluno_id
GROUP BY a.id;


CREATE VIEW disciplinas_curso_especifico AS
SELECT d.*
FROM disciplinas d
JOIN cursos c ON d.curso_id = c.id
WHERE c.nome = 'Engenharia de Software';

CREATE VIEW professores_sem_turmas AS
SELECT p.nome AS professor
FROM professores p
LEFT JOIN turmas t ON p.id = t.professor_id
WHERE t.id IS NULL;

CREATE VIEW alunos_cpf_email AS
SELECT nome, cpf, email
FROM alunos;

CREATE VIEW total_disciplinas_por_professor AS
SELECT p.nome AS professor, COUNT(d.id) AS total_disciplinas
FROM professores p
JOIN turmas t ON p.id = t.professor_id
JOIN disciplinas d ON t.disciplina_id = d.id