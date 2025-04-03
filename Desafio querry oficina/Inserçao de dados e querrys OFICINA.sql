use oficina;


INSERT INTO tratado (nome, endereco, especialidade) VALUES
('Joao Carlos Silva', 'Rua dos Mecânicos, 123 - São Paulo/SP', 'Mecânica Geral'),
('Maria Oliveira Santos', 'Av. das Engrenagens, 456 - São Paulo/SP', 'Elétrica Automotiva'),
('Carlos Eduardo Rocha', 'Travessa dos Motores, 789 - São Paulo/SP', 'Motor e Transmissão'),
('Ana Paula Mendes', 'Alameda dos Freios, 101 - São Paulo/SP', 'Suspensão e Freios'),
('Roberto Almeida', 'Rua das Baterias, 202 - São Paulo/SP', 'Sistema Elétrico');

-- Inserção de clientes
INSERT INTO cliente (nome, sobrenome, cpf, placa_carro, telefone) VALUES
('Marcos', 'Aurelio', '12345678901', 'ABC1D23', '(11) 9999-8888'),
('Juliana', 'Mendes', '23456789012', 'XYZ9F87', '(11) 98877-6655'),
('Felipe', 'Nogueira', '34567890123', 'JKL4M56', '(11) 97766-5544'),
('Amanda', 'Souza', '45678901234', 'QWE3R45', '(11) 96655-4433'),
('Ricardo', 'Ferreira', '56789012345', 'ASD2F34', '(11) 95544-3322'),
('Patricia', 'Gomes', '67890123456', 'BNM7K89', '(11) 94433-2211');

-- Inserção de ordens de serviço
INSERT INTO ordem_servico (idOrdem,idcliente, idtratado, data_servico, status, observacoes) VALUES
(1,1, 3, '2023-11-01', 'concluído', 'Barulho estranho no motor ao acelerar'),
(2,2, 2, '2023-11-02', 'em andamento', 'Faróis não acendem e bateria descarregando rápido'),
(3,3, 1, '2023-11-03', 'concluído', 'Revisão periódica de 10.000 km'),
(4,4, 4, '2023-11-04', 'concluído', 'Troca de pastilhas de freio e discos'),
(5,5, 5, '2023-11-05', 'em andamento', 'Problema no sistema de injeção eletrônica'),
(6,6, 1, '2023-11-06', 'aberto', 'Alinhamento e balanceamento'),
(7,1, 3, '2023-11-07', 'aguardando peças', 'Vazamento de óleo no motor');

-- Inserção de serviços
INSERT INTO servico (idordem, tipo, preco, data_conclusao, endereco_execucao, descricao) VALUES
(1, 'concerto', 1250.00, '2023-11-03', 'Oficina Centro', 'Troca de biela e retificação do motor'),
(2, 'concerto', 420.50, NULL, 'Oficina Centro', 'Substituição do alternador e reparo no sistema elétrico'),
(3, 'revisao', 580.00, '2023-11-05', 'Oficina Centro', 'Revisão completa: óleo, filtros, velas e correias'),
(4, 'concerto', 890.00, '2023-11-06', 'Oficina Centro', 'Troca completa do sistema de freios'),
(5, 'concerto', 720.00, NULL, 'Oficina Centro', 'Limpeza dos bicos injetores e regulagem'),
(6, 'revisao', 350.00, NULL, 'Oficina Centro', 'Alinhamento, balanceamento e geometria'),
(7, 'concerto', 680.00, NULL, 'Oficina Centro', 'Troca de junta do cárter e retificação');

-- Verificar todos os profissionais cadastrados
SELECT * FROM tratado;

-- Verificar todos os clientes cadastrados
SELECT * FROM cliente;

-- Verificar todas as ordens de serviço
SELECT * FROM ordem_servico;

-- Verificar todos os serviços realizados
SELECT * FROM servico;

-- Verificar ordens de serviço com detalhes de clientes e profissionais
SELECT 
    os.idordem,
    CONCAT(c.nome, ' ', c.sobrenome) AS cliente,
    c.placa_carro,
    t.nome AS profissional,
    t.especialidade,
    os.data_servico,
    os.status
FROM ordem_servico os
JOIN cliente c ON os.idcliente = c.idcliente
JOIN tratado t ON os.idtratado = t.idtratado
ORDER BY os.data_servico DESC;


-- Total de serviços por status
SELECT 
    os.status,
    COUNT(s.idservico) AS quantidade_servicos,
    SUM(s.preco) AS valor_total
FROM servico s
JOIN ordem_servico os ON s.idordem = os.idordem
GROUP BY os.status;

-- Faturamento por profissional
SELECT 
    t.nome AS profissional,
    t.especialidade,
    COUNT(s.idservico) AS servicos_realizados,
    SUM(s.preco) AS faturamento
FROM servico s
JOIN ordem_servico os ON s.idordem = os.idordem
JOIN tratado t ON os.idtratado = t.idtratado
GROUP BY t.nome, t.especialidade
ORDER BY faturamento DESC;

SELECT 
    t.nome AS profissional,
    COUNT(s.idservico) AS total_servicos
FROM tratado t
JOIN ordem_servico os ON t.idtratado = os.idtratado
JOIN servico s ON os.idordem = s.idordem
GROUP BY t.nome
HAVING COUNT(s.idservico) > 2;
