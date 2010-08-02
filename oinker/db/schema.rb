# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100801151802) do

  create_table "bcRegra_Sugestao", :id => false, :force => true do |t|
    t.integer "idRegra",    :null => false
    t.integer "idSugestao", :null => false
  end

  add_index "bcRegra_Sugestao", ["idRegra", "idSugestao"], :name => "bcRegras_Sugestao_UK", :unique => true
  add_index "bcRegra_Sugestao", ["idRegra"], :name => "bcRegras_Sugestao_bcRegras_FK"
  add_index "bcRegra_Sugestao", ["idSugestao"], :name => "bcRegras_Sugestao_stiSugestao_FK"

  create_table "bcRegras", :primary_key => "idRegra", :force => true do |t|
    t.string  "esforco",      :limit => 20, :null => false
    t.string  "resultado",    :limit => 20, :null => false
    t.string  "desempenho",   :limit => 20, :null => false
    t.integer "animation_id"
    t.string  "participacao", :limit => 20, :null => false
  end

  add_index "bcRegras", ["animation_id"], :name => "animation_id"

  create_table "bdqAberta", :id => false, :force => true do |t|
    t.integer "idQuestao",                :null => false
    t.string  "resposta",  :limit => 500, :null => false
  end

  add_index "bdqAberta", ["idQuestao"], :name => "bdqAberta_bdqquestao_FK"

  create_table "bdqAluno_RespostaAvulsa", :id => false, :force => true do |t|
    t.integer "idQuestao",                   :null => false
    t.integer "chavePessoa",                 :null => false
    t.string  "solucao",        :limit => 1, :null => false
    t.integer "tempoSolucao",                :null => false
    t.date    "dtSolucao",                   :null => false
    t.time    "horarioSolucao",              :null => false
  end

  add_index "bdqAluno_RespostaAvulsa", ["chavePessoa"], :name => "bdqAluno_RespostaAvulsa_maiorPessoa_FK"
  add_index "bdqAluno_RespostaAvulsa", ["idQuestao", "chavePessoa", "dtSolucao", "horarioSolucao"], :name => "bdqAluno_RespostaAvulsa_UK", :unique => true

  create_table "bdqAluno_RespostaLista", :id => false, :force => true do |t|
    t.integer "idLista",                     :null => false
    t.integer "idQuestao",                   :null => false
    t.integer "chavePessoa",                 :null => false
    t.string  "solucao",        :limit => 1, :null => false
    t.integer "tempoSolucao",                :null => false
    t.date    "dtSolucao",                   :null => false
    t.time    "horarioSolucao",              :null => false
  end

  add_index "bdqAluno_RespostaLista", ["chavePessoa"], :name => "bdqAluno_RespostaLista_maiorPessoa_FK"
  add_index "bdqAluno_RespostaLista", ["idLista", "idQuestao", "chavePessoa", "dtSolucao"], :name => "bdqAluno_RespostaLista_UK", :unique => true
  add_index "bdqAluno_RespostaLista", ["idQuestao"], :name => "bdqAluno_RespostaLista_bdqQuestao_FK"

  create_table "bdqEscolhas", :id => false, :force => true do |t|
    t.integer "idQuestao",                       :null => false
    t.string  "resposta",         :limit => 1,   :null => false
    t.string  "opcao1",           :limit => 150, :null => false
    t.string  "opcao2",           :limit => 150, :null => false
    t.string  "opcao3",           :limit => 150, :null => false
    t.string  "opcao4",           :limit => 150, :null => false
    t.string  "comentarioCerto",  :limit => 100, :null => false
    t.string  "comentarioErrado", :limit => 100, :null => false
  end

  add_index "bdqEscolhas", ["idQuestao"], :name => "bdqEscolhas_bdqquestao_FK"

  create_table "bdqLacuna", :id => false, :force => true do |t|
    t.integer "idQuestao",                          :null => false
    t.string  "resposta",            :limit => 20,  :null => false
    t.string  "frase",               :limit => 150, :null => false
    t.string  "comentarioCerto",     :limit => 100, :null => false
    t.string  "comentarioErrado",    :limit => 100, :null => false
    t.string  "respostaAlternativa", :limit => 20
  end

  add_index "bdqLacuna", ["idQuestao"], :name => "bdqLacuna_bdqquestao_FK"

  create_table "bdqLista", :primary_key => "idLista", :force => true do |t|
    t.integer "chavePessoaProfessor",               :null => false
    t.string  "tituloLista",          :limit => 20, :null => false
    t.string  "categoria",            :limit => 1,  :null => false
    t.integer "quantidadeQuestoes",                 :null => false
    t.date    "dtCriacao",                          :null => false
    t.string  "chaveAcesso",          :limit => 15
  end

  add_index "bdqLista", ["chavePessoaProfessor"], :name => "bdqLista_maiorProfessor_FK"

  create_table "bdqLista_Questao", :id => false, :force => true do |t|
    t.integer "idLista",   :null => false
    t.integer "idQuestao", :null => false
  end

  add_index "bdqLista_Questao", ["idLista"], :name => "bdqLista_Questao_bdqLista_FK"
  add_index "bdqLista_Questao", ["idQuestao"], :name => "bdqLista_Questao_bdqQuestao_FK"

  create_table "bdqLista_Turma", :id => false, :force => true do |t|
    t.integer "idLista",                           :null => false
    t.string  "codigoTurma",          :limit => 4, :null => false
    t.integer "codigoCurso",                       :null => false
    t.integer "idDisciplina",                      :null => false
    t.integer "ano",                               :null => false
    t.string  "semestre",             :limit => 1, :null => false
    t.date    "dtLimiteEntrega",                   :null => false
    t.time    "horarioLimiteEntrega",              :null => false
  end

  add_index "bdqLista_Turma", ["codigoTurma", "codigoCurso", "idDisciplina", "ano", "semestre"], :name => "bdqLista_Turma_maiorTurma_FK"
  add_index "bdqLista_Turma", ["idLista", "codigoTurma", "codigoCurso", "idDisciplina", "ano", "semestre"], :name => "bdqLista_Turma_UK", :unique => true

  create_table "bdqMultipla", :id => false, :force => true do |t|
    t.integer "idQuestao",                  :null => false
    t.string  "resposta",    :limit => 1,   :null => false
    t.string  "opcao1",      :limit => 150, :null => false
    t.string  "opcao2",      :limit => 150, :null => false
    t.string  "opcao3",      :limit => 150, :null => false
    t.string  "opcao4",      :limit => 150, :null => false
    t.string  "comentario1", :limit => 100, :null => false
    t.string  "comentario2", :limit => 100, :null => false
    t.string  "comentario3", :limit => 100, :null => false
    t.string  "comentario4", :limit => 100, :null => false
  end

  add_index "bdqMultipla", ["idQuestao"], :name => "bdqMultipla_bdqquestao_FK"

  create_table "bdqQuestao", :primary_key => "idQuestao", :force => true do |t|
    t.integer "idDisciplina",                :null => false
    t.integer "idConteudo",                  :null => false
    t.integer "chavePessoa",                 :null => false
    t.string  "enunciado",    :limit => 250, :null => false
    t.string  "tipoQuestao",  :limit => 1,   :null => false
    t.string  "dificuldade",  :limit => 1,   :null => false
    t.string  "categoria",    :limit => 1,   :null => false
    t.integer "tempo",                       :null => false
    t.date    "dtcriacao",                   :null => false
  end

  add_index "bdqQuestao", ["chavePessoa"], :name => "bdqQuestao_maiorPessoa_FK"
  add_index "bdqQuestao", ["idConteudo"], :name => "bdqQuestao_maiorConteudo_FK"
  add_index "bdqQuestao", ["idDisciplina"], :name => "bdqQuestao_maiorDisciplina_FK"

  create_table "bdqRespostaAvulsa_Aberta", :id => false, :force => true do |t|
    t.integer "idQuestao",                     :null => false
    t.integer "chavePessoa",                   :null => false
    t.date    "dtSolucao",                     :null => false
    t.time    "horarioSolucao",                :null => false
    t.string  "correcao",       :limit => 1,   :null => false
    t.string  "solucao",        :limit => 500
  end

  add_index "bdqRespostaAvulsa_Aberta", ["idQuestao", "chavePessoa", "dtSolucao", "horarioSolucao"], :name => "bdqRespostaAvulsa_Aberta_FK"

  create_table "bdqRespostaLista_Aberta", :id => false, :force => true do |t|
    t.integer "idLista",                    :null => false
    t.integer "idQuestao",                  :null => false
    t.integer "chavePessoa",                :null => false
    t.string  "correcao",    :limit => 1,   :null => false
    t.string  "solucao",     :limit => 500
  end

  add_index "bdqRespostaLista_Aberta", ["idLista", "idQuestao", "chavePessoa"], :name => "bdqRespostaLista_Aberta_FK"

  create_table "bdqVouF", :id => false, :force => true do |t|
    t.integer "idQuestao",                       :null => false
    t.string  "resposta",         :limit => 1,   :null => false
    t.string  "comentarioCerto",  :limit => 100, :null => false
    t.string  "comentarioErrado", :limit => 100, :null => false
  end

  add_index "bdqVouF", ["idQuestao"], :name => "bdqVouF_bdqquestao_FK"

  create_table "big_shots", :force => true do |t|
    t.string   "screen_name"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maiorAcesso", :primary_key => "chavePessoa", :force => true do |t|
    t.string "login", :limit => 70, :null => false
    t.string "senha", :limit => 10, :null => false
  end

  add_index "maiorAcesso", ["chavePessoa"], :name => "maiorAcesso_UK", :unique => true
  add_index "maiorAcesso", ["login"], :name => "login_UK", :unique => true

  create_table "maiorAdministrador", :id => false, :force => true do |t|
    t.integer "chavePessoa", :null => false
    t.date    "dtRegistro",  :null => false
  end

  add_index "maiorAdministrador", ["chavePessoa"], :name => "maiorAdministrador_maiorPessoa_FK"

  create_table "maiorAluno", :primary_key => "matricula", :force => true do |t|
    t.integer "chavePessoa",              :null => false
    t.date    "dtRegistro",               :null => false
    t.integer "codigoCurso",              :null => false
    t.string  "situacao",    :limit => 1, :null => false
  end

  add_index "maiorAluno", ["chavePessoa"], :name => "maiorAluno_maiorPessoa_FK"
  add_index "maiorAluno", ["codigoCurso"], :name => "maiorAluno_maiorCurso_FK"
  add_index "maiorAluno", ["matricula"], :name => "maiorAluno_UK", :unique => true

  create_table "maiorConteudo", :primary_key => "idConteudo", :force => true do |t|
    t.integer "idDisciplina",                :null => false
    t.string  "descricao",    :limit => 100, :null => false
    t.integer "monitoria",                   :null => false
    t.integer "questoes",                    :null => false
    t.integer "ordem",                       :null => false
  end

  add_index "maiorConteudo", ["idDisciplina"], :name => "maiorConteudo_maiorDisciplina_FK"

  create_table "maiorCurso", :primary_key => "codigoCurso", :force => true do |t|
    t.string "nomeCurso", :limit => 50, :null => false
  end

  create_table "maiorCurso_Disciplina", :id => false, :force => true do |t|
    t.integer "codigoCurso",  :null => false
    t.integer "idDisciplina", :null => false
  end

  add_index "maiorCurso_Disciplina", ["codigoCurso"], :name => "maiorCurso_Disciplina_maiorCurso_FK"
  add_index "maiorCurso_Disciplina", ["idDisciplina"], :name => "maiorCurso_Disciplina_maiorDisciplina_FK"

  create_table "maiorDiretor", :id => false, :force => true do |t|
    t.integer "chavePessoa",                       :null => false
    t.date    "dtRegistro",                        :null => false
    t.integer "codigoCurso",                       :null => false
    t.string  "maiorTitulo",        :limit => 100, :null => false
    t.string  "situacao",           :limit => 1,   :null => false
    t.string  "matriculaFuncional", :limit => 11,  :null => false
  end

  add_index "maiorDiretor", ["chavePessoa"], :name => "maiorDiretor_maiorPessoa_FK"

  create_table "maiorDisciplina", :primary_key => "idDisciplina", :force => true do |t|
    t.string  "nomeDisciplina",   :limit => 50,                     :null => false
    t.string  "objetivo",         :limit => 500,                    :null => false
    t.integer "cargaHoraria",                                       :null => false
    t.integer "nivelMedio",                                         :null => false
    t.boolean "ativa_integracao",                :default => false, :null => false
  end

  create_table "maiorMonitor", :id => false, :force => true do |t|
    t.integer "chavePessoa",               :null => false
    t.integer "idDisciplina",              :null => false
    t.integer "ano",                       :null => false
    t.string  "semestre",     :limit => 1, :null => false
    t.date    "dtRegistro",                :null => false
    t.date    "dtSaida"
  end

  add_index "maiorMonitor", ["chavePessoa", "idDisciplina", "ano", "semestre"], :name => "maiorMonitor_UK", :unique => true
  add_index "maiorMonitor", ["chavePessoa"], :name => "maiorMonitor_maiorPessoa_FK"
  add_index "maiorMonitor", ["idDisciplina"], :name => "maiorMonitor_maiorDisciplina_FK"

  create_table "maiorPessoa", :primary_key => "chavePessoa", :force => true do |t|
    t.string "nomePessoa", :limit => 50,  :null => false
    t.date   "dtNascer",                  :null => false
    t.string "cpf",        :limit => 11,  :null => false
    t.string "sexo",       :limit => 1,   :null => false
    t.string "email",      :limit => 50,  :null => false
    t.string "situacao",   :limit => 1,   :null => false
    t.string "apelido",    :limit => 15,  :null => false
    t.string "webPessoal", :limit => 100
  end

  add_index "maiorPessoa", ["cpf"], :name => "maiorPessoa_UK", :unique => true

  create_table "maiorProfessor", :id => false, :force => true do |t|
    t.integer "chavePessoa",                       :null => false
    t.date    "dtRegistro",                        :null => false
    t.integer "codigoCursoVinculo",                :null => false
    t.string  "maiorTitulo",        :limit => 100, :null => false
    t.string  "situacao",           :limit => 1,   :null => false
    t.string  "matriculaFuncional", :limit => 11,  :null => false
  end

  add_index "maiorProfessor", ["chavePessoa"], :name => "maiorProfessor_maiorPessoa_FK"
  add_index "maiorProfessor", ["codigoCursoVinculo"], :name => "maiorProfessor_maiorCurso_FK"

  create_table "maiorTurma", :id => false, :force => true do |t|
    t.string  "codigoTurma",          :limit => 4,  :null => false
    t.integer "codigoCurso",                        :null => false
    t.integer "idDisciplina",                       :null => false
    t.integer "ano",                                :null => false
    t.string  "semestre",             :limit => 1,  :null => false
    t.integer "chavePessoaProfessor",               :null => false
    t.string  "diaSemana",            :limit => 5,  :null => false
    t.string  "horarioAula",          :limit => 20, :null => false
    t.string  "turno",                :limit => 1,  :null => false
    t.string  "sala",                 :limit => 6,  :null => false
  end

  add_index "maiorTurma", ["chavePessoaProfessor"], :name => "maiorTurma_maiorProfessor_FK"
  add_index "maiorTurma", ["codigoCurso", "idDisciplina"], :name => "maiorTurma_maiorCurso_Disciplina_FK"

  create_table "maiorTurma_Aluno", :id => false, :force => true do |t|
    t.string  "codigoTurma",      :limit => 4, :null => false
    t.integer "codigoCurso",                   :null => false
    t.integer "idDisciplina",                  :null => false
    t.integer "ano",                           :null => false
    t.string  "semestre",         :limit => 1, :null => false
    t.integer "chavePessoaAluno",              :null => false
  end

  add_index "maiorTurma_Aluno", ["codigoTurma", "codigoCurso", "idDisciplina", "ano", "semestre"], :name => "maiorTurma_Aluno_maiorTurma_FK"
  add_index "maiorTurma_Aluno", ["idDisciplina", "ano", "semestre", "chavePessoaAluno"], :name => "maiorTurma_UK", :unique => true

  create_table "maiorturma_externa", :force => true do |t|
    t.string  "codigoTurma",    :limit => 4,  :null => false
    t.integer "codigoCurso",                  :null => false
    t.integer "idDisciplina",                 :null => false
    t.integer "ano",                          :null => false
    t.string  "semestre",       :limit => 1,  :null => false
    t.string  "idTurmaExterna", :limit => 12, :null => false
    t.string  "sistema",        :limit => 0,  :null => false
  end

  add_index "maiorturma_externa", ["codigoTurma", "codigoCurso", "idDisciplina", "ano", "semestre", "sistema"], :name => "turma_unique", :unique => true
  add_index "maiorturma_externa", ["idTurmaExterna", "sistema"], :name => "turma_externa_index"

  create_table "maiorusuario_externo", :force => true do |t|
    t.integer "chavePessoa",               :null => false
    t.string  "iduser",      :limit => 64, :null => false
    t.string  "sistema",     :limit => 0,  :null => false
  end

  add_index "maiorusuario_externo", ["chavePessoa", "sistema"], :name => "chavepessoa_sistema_index"
  add_index "maiorusuario_externo", ["iduser", "sistema"], :name => "usuario_unico", :unique => true

  create_table "minaAnimation", :force => true do |t|
    t.string "name",        :limit => 30,  :null => false
    t.string "description", :limit => 200, :null => false
  end

  create_table "pmAtendimento", :primary_key => "idAtendimento", :force => true do |t|
    t.integer "chavePessoaAluno",                :null => false
    t.integer "chavePessoaMonitor",              :null => false
    t.integer "idDisciplina",                    :null => false
    t.integer "duracao",                         :null => false
    t.string  "localAtender",       :limit => 1, :null => false
    t.date    "dtAtendimento",                   :null => false
    t.integer "idConteudo",                      :null => false
  end

  add_index "pmAtendimento", ["chavePessoaAluno"], :name => "pmAtendimento_maiorAluno_FK"
  add_index "pmAtendimento", ["chavePessoaMonitor"], :name => "pmAtendimento_maiorMonitor_FK"
  add_index "pmAtendimento", ["idConteudo"], :name => "pmAtendimento_maiorConteudo_FK"
  add_index "pmAtendimento", ["idDisciplina"], :name => "pmAtendimento_maiorDisciplina_FK"

  create_table "pmFrequencia", :id => false, :force => true do |t|
    t.integer "chavePessoaMonitor",               :null => false
    t.date    "dtEntrada",                        :null => false
    t.time    "horaEntrada",                      :null => false
    t.string  "autenticaEntrada",   :limit => 16, :null => false
    t.time    "horaSaida"
    t.string  "autenticaSaida",     :limit => 16
  end

  add_index "pmFrequencia", ["chavePessoaMonitor"], :name => "pmFrequencia_maiorMonitor_FK"

  create_table "pmMonitoria", :id => false, :force => true do |t|
    t.integer "chavePessoaAluno",               :null => false
    t.integer "idDisciplina",                   :null => false
    t.integer "ano",                            :null => false
    t.string  "semestre",         :limit => 1,  :null => false
    t.string  "sala",             :limit => 25, :null => false
    t.string  "diaSemana",        :limit => 10, :null => false
    t.string  "horario",          :limit => 55, :null => false
    t.string  "campus",           :limit => 1,  :null => false
  end

  add_index "pmMonitoria", ["chavePessoaAluno", "idDisciplina", "ano", "semestre"], :name => "pmMonitoria_UK", :unique => true
  add_index "pmMonitoria", ["chavePessoaAluno"], :name => "pmMonitoria_maiorAluno_FK"
  add_index "pmMonitoria", ["idDisciplina"], :name => "pmMonitoria_maiorDisciplina_FK"

  create_table "pmParecer", :id => false, :force => true do |t|
    t.integer "idAtendimento",                   :null => false
    t.string  "parecerMonitor",   :limit => 100, :null => false
    t.string  "notificar",        :limit => 1,   :null => false
    t.string  "parecerProfessor", :limit => 100
  end

  add_index "pmParecer", ["idAtendimento"], :name => "pmParecer_pmAtendimento_FK"

  create_table "stiAcompanhamento", :primary_key => "idAcompanhamento", :force => true do |t|
    t.integer "idDisciplina",                  :null => false
    t.integer "ano",                           :null => false
    t.string  "semestre",         :limit => 1, :null => false
    t.integer "chavePessoaAluno",              :null => false
  end

  add_index "stiAcompanhamento", ["chavePessoaAluno"], :name => "stiAcompanhamento_maiorAluno_FK"
  add_index "stiAcompanhamento", ["idDisciplina", "ano", "semestre", "chavePessoaAluno"], :name => "stiAcompanhamento_UK", :unique => true
  add_index "stiAcompanhamento", ["idDisciplina", "ano", "semestre", "chavePessoaAluno"], :name => "stiAcompanhamento_maiorTurma_Aluno_FK"
  add_index "stiAcompanhamento", ["idDisciplina"], :name => "stiAcompanhamento_maiorDisciplina_FK"

  create_table "stiConselho", :id => false, :force => true do |t|
    t.integer "idOrientacao", :null => false
    t.integer "idSugestao",   :null => false
  end

  add_index "stiConselho", ["idOrientacao"], :name => "stiConselho_stiOrientacao_FK"
  add_index "stiConselho", ["idSugestao"], :name => "stiConselho_stiSugestao_FK"

  create_table "stiOrientacao", :primary_key => "idOrientacao", :force => true do |t|
    t.integer "idAcompanhamento",                                            :null => false
    t.integer "idConteudo",                                                  :null => false
    t.date    "dtOrientacao",                                                :null => false
    t.time    "horaOrientacao",                                              :null => false
    t.string  "situacao",         :limit => 1,                               :null => false
    t.decimal "relativo",                      :precision => 4, :scale => 2, :null => false
  end

  add_index "stiOrientacao", ["idAcompanhamento"], :name => "stiOrientacao_stiAcompanhamento_FK"
  add_index "stiOrientacao", ["idConteudo"], :name => "stiOrientacao_maiorConteudo_FK"

  create_table "stiSugestao", :primary_key => "idSugestao", :force => true do |t|
    t.string "sugestao", :limit => 150, :null => false
    t.string "contexto", :limit => 20,  :null => false
  end

  create_table "tweeters", :force => true do |t|
    t.datetime "created_at"
    t.integer  "friends_count"
    t.string   "profile_image_url"
    t.integer  "followers_count"
    t.string   "screen_name"
    t.string   "location"
    t.boolean  "geo_enabled"
    t.string   "time_zone"
    t.boolean  "protected"
    t.string   "description"
    t.string   "profile_background_image_url"
    t.string   "url"
    t.integer  "statuses_count"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.datetime "created_at"
    t.integer  "tweeter_id"
    t.integer  "twitter_id"
    t.string   "text"
    t.string   "source"
    t.integer  "in_reply_to_status_id"
    t.string   "in_reply_to_screen_name"
    t.datetime "updated_at"
  end

end
