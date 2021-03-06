# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180716204605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dia_pontos", force: :cascade do |t|
    t.datetime "data"
    t.integer  "user_id"
    t.integer  "parametro_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["parametro_id"], name: "index_dia_pontos_on_parametro_id", using: :btree
    t.index ["user_id"], name: "index_dia_pontos_on_user_id", using: :btree
  end

  create_table "empresas", force: :cascade do |t|
    t.boolean  "ativo",                                           default: true
    t.string   "razao_social"
    t.string   "nome_fantasia"
    t.string   "email"
    t.string   "telefone_1"
    t.string   "telefone_2"
    t.decimal  "vlr_hora",               precision: 10, scale: 2, default: "0.0"
    t.integer  "percentual_hora_extra",                           default: 0
    t.integer  "percentual_add_noturno",                          default: 0
    t.integer  "tipo_contrato_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.index ["tipo_contrato_id"], name: "index_empresas_on_tipo_contrato_id", using: :btree
    t.index ["user_id"], name: "index_empresas_on_user_id", using: :btree
  end

  create_table "escala_trabalho_horarios", force: :cascade do |t|
    t.string   "descricao"
    t.time     "hora_inicio"
    t.time     "hora_fim"
    t.integer  "escala_trabalho_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["escala_trabalho_id"], name: "index_escala_trabalho_horarios_on_escala_trabalho_id", using: :btree
  end

  create_table "escala_trabalhos", force: :cascade do |t|
    t.string   "descricao"
    t.text     "obs"
    t.boolean  "ativo",      default: true
    t.integer  "user_id"
    t.integer  "empresa_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["empresa_id"], name: "index_escala_trabalhos_on_empresa_id", using: :btree
    t.index ["user_id"], name: "index_escala_trabalhos_on_user_id", using: :btree
  end

  create_table "parametros", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "empresa_id"
    t.integer  "escala_trabalho_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["empresa_id"], name: "index_parametros_on_empresa_id", using: :btree
    t.index ["escala_trabalho_id"], name: "index_parametros_on_escala_trabalho_id", using: :btree
    t.index ["user_id"], name: "index_parametros_on_user_id", using: :btree
  end

  create_table "pontos", force: :cascade do |t|
    t.time     "hora_inicio"
    t.time     "hora_fim"
    t.integer  "user_id"
    t.integer  "dia_ponto_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["dia_ponto_id"], name: "index_pontos_on_dia_ponto_id", using: :btree
    t.index ["user_id"], name: "index_pontos_on_user_id", using: :btree
  end

  create_table "tipo_contratos", force: :cascade do |t|
    t.string   "descricao"
    t.text     "obs"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tipo_contratos_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "auth_token"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "name"
    t.text     "tokens"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "dia_pontos", "parametros"
  add_foreign_key "dia_pontos", "users"
  add_foreign_key "empresas", "tipo_contratos"
  add_foreign_key "empresas", "users"
  add_foreign_key "escala_trabalho_horarios", "escala_trabalhos"
  add_foreign_key "escala_trabalhos", "empresas"
  add_foreign_key "escala_trabalhos", "users"
  add_foreign_key "parametros", "empresas"
  add_foreign_key "parametros", "escala_trabalhos"
  add_foreign_key "parametros", "users"
  add_foreign_key "pontos", "dia_pontos"
  add_foreign_key "pontos", "users"
  add_foreign_key "tipo_contratos", "users"
end
