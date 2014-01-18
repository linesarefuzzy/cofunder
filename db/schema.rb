# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130316223303) do

  create_table "AccountClasses", :primary_key => "ID", :force => true do |t|
    t.string "ClassID",      :null => false
    t.string "SuperClassID"
    t.string "Name",         :null => false
    t.string "Nombre",       :null => false
    t.text   "Description"
  end

  add_index "accountclasses", ["ClassID"], :name => "ClassID"
  add_index "accountclasses", ["SuperClassID"], :name => "SuperClassID"

  create_table "AccountTypes", :primary_key => "ID", :force => true do |t|
    t.string "Name",        :limit => 50, :default => "", :null => false
    t.text   "Description",                               :null => false
  end

  create_table "Accounts", :primary_key => "ID", :force => true do |t|
    t.string  "ExternalAccountingID",   :limit => 15
    t.string  "Name",                                 :default => "", :null => false
    t.string  "Nombre",                                               :null => false
    t.string  "ExternalAccountingName"
    t.integer "DivisionID",                           :default => 0,  :null => false
    t.integer "Currency",               :limit => 1,  :default => 1,  :null => false
    t.text    "Description",                                          :null => false
    t.integer "Type",                                 :default => 0,  :null => false
    t.integer "ExternalParty"
  end

  add_index "accounts", ["DivisionID"], :name => "AccountOwnerID"
  add_index "accounts", ["ExternalAccountingID", "DivisionID"], :name => "ExternalAccountingID", :unique => true
  add_index "accounts", ["Name", "DivisionID"], :name => "NameDivision", :unique => true

  create_table "BasicProjects", :primary_key => "ID", :force => true do |t|
    t.string   "Type",             :limit => 30,  :default => "Basic",      :null => false
    t.float    "Length",                          :default => 0.0,          :null => false
    t.string   "Nivel",            :limit => 200, :default => "Relacion",   :null => false
    t.integer  "Coordinator"
    t.integer  "Assistant"
    t.integer  "Goal",             :limit => 2
    t.datetime "StartDate"
    t.string   "Name",                            :default => "Sin Nombre", :null => false
    t.text     "ShortDescription",                                          :null => false
    t.text     "Description"
  end

  add_index "basicprojects", ["Coordinator"], :name => "MemberID"
  add_index "basicprojects", ["Nivel"], :name => "type"
  add_index "basicprojects", ["StartDate"], :name => "SigningDate"

  create_table "Blog", :primary_key => "ID", :force => true do |t|
    t.string   "Title", :null => false
    t.binary   "Text",  :null => false
    t.string   "Type",  :null => false
    t.datetime "Date",  :null => false
  end

  create_table "Checks", :primary_key => "ID", :force => true do |t|
    t.string  "Banco",             :limit => 200
    t.string  "NumeroDeCheque",    :limit => 50
    t.string  "AccountHolder"
    t.float   "Amount",                           :null => false
    t.integer "LoanID",                           :null => false
    t.date    "DateEntered",                      :null => false
    t.date    "DateDue",                          :null => false
    t.date    "DateRemoved"
    t.date    "DateBounced"
    t.string  "NumeroDeRecibo"
    t.float   "Descuento"
    t.float   "Exidente"
    t.float   "GastosFinancieros"
    t.float   "Impuesto"
    t.integer "NewLoanID"
    t.integer "Bounced",           :limit => 1
    t.text    "Notes"
  end

  create_table "Cooperatives", :primary_key => "ID", :force => true do |t|
    t.integer  "LaBaseFundAccountID"
    t.integer  "RedTekufenFundAccountID"
    t.string   "Name",                    :limit => 250,                     :null => false
    t.string   "NombreLegalCompleto",                    :default => "Coop", :null => false
    t.string   "Alias",                   :limit => 200
    t.text     "Address"
    t.string   "City",                    :limit => 200, :default => "",     :null => false
    t.string   "Country",                 :limit => 200, :default => "",     :null => false
    t.string   "web"
    t.text     "Contact"
    t.string   "Ownership",               :limit => 250
    t.datetime "OwnershipChangeDate"
    t.integer  "Recuperada",              :limit => 1,   :default => 0,      :null => false
    t.string   "Sector",                  :limit => 200
    t.string   "Industry",                :limit => 200
    t.string   "Source",                  :limit => 250
  end

  add_index "cooperatives", ["Name"], :name => "Name"
  add_index "cooperatives", ["Ownership", "OwnershipChangeDate"], :name => "ownership"
  add_index "cooperatives", ["Sector", "Industry"], :name => "sector"

  create_table "Countries", :primary_key => "ID", :force => true do |t|
    t.string  "Name",       :null => false
    t.integer "LanguageID"
  end

  add_index "countries", ["Name"], :name => "Name", :unique => true

  create_table "Currencies", :primary_key => "ID", :force => true do |t|
    t.string  "Name",            :limit => 50, :default => "",          :null => false
    t.string  "Symbol",          :limit => 20, :default => "",          :null => false
    t.text    "Description",                                            :null => false
    t.integer "DefaultCurrency", :limit => 1,  :default => 0,           :null => false
    t.string  "Country",                       :default => "Argentina", :null => false
    t.float   "ExchangeRate",                  :default => 1.0,         :null => false
  end

  add_index "currencies", ["DefaultCurrency"], :name => "Default"

  create_table "Divisions", :primary_key => "ID", :force => true do |t|
    t.string  "Name",                           :default => "",          :null => false
    t.string  "ExternalName"
    t.integer "AccountDivision",                :default => 2,           :null => false
    t.integer "SuperDivision"
    t.string  "Country",         :limit => 120, :default => "Argentina", :null => false
    t.text    "Description",                                             :null => false
  end

  add_index "divisions", ["Name"], :name => "Name"

  create_table "ExchangeRates", :primary_key => "ID", :force => true do |t|
    t.integer "CurrencyID",                             :null => false
    t.float   "ExchangeRate",                           :null => false
    t.date    "DateStart",                              :null => false
    t.date    "DateEnd",      :default => '2009-01-01', :null => false
  end

  create_table "Goals", :primary_key => "ID", :force => true do |t|
    t.string  "Name",             :limit => 50, :default => "", :null => false
    t.text    "Description",                                    :null => false
    t.date    "DateActivated",                                  :null => false
    t.date    "DateDisactivated"
    t.integer "SuperGoal",        :limit => 2
  end

  create_table "GroupTransactionIDs", :primary_key => "ID", :force => true do |t|
    t.integer  "StarterTransaction"
    t.datetime "DateCreated",        :null => false
  end

  create_table "InflowTypes", :primary_key => "ID", :force => true do |t|
    t.string "Name",        :limit => 50, :default => "",         :null => false
    t.string "Nombre"
    t.text   "Description",                                       :null => false
    t.string "Scope",       :limit => 70, :default => "External", :null => false
    t.string "FromAccount"
    t.string "ToAccount"
  end

  create_table "Inventory", :primary_key => "ID", :force => true do |t|
    t.string   "ProductID",      :limit => 50,                 :null => false
    t.integer  "ProductSubtype"
    t.string   "Location",       :limit => 100,                :null => false
    t.integer  "Quantity",                                     :null => false
    t.integer  "Current",        :limit => 1,   :default => 1, :null => false
    t.datetime "DateModified",                                 :null => false
  end

  add_index "inventory", ["Current"], :name => "Current"

  create_table "Languages", :primary_key => "ID", :force => true do |t|
    t.string  "Code",     :limit => 2,   :null => false
    t.string  "Name",     :limit => 200, :null => false
    t.integer "Priority", :limit => 2,   :null => false
    t.string  "Country",  :limit => 500
  end

  create_table "LoanAgentTransactions", :primary_key => "ID", :force => true do |t|
    t.integer "Account",           :limit => 2, :default => 0, :null => false
    t.integer "MemberID",                       :default => 2
    t.integer "Loan",              :limit => 2
    t.integer "InflowType",        :limit => 1
    t.integer "OutflowType",       :limit => 1
    t.text    "Description",                                   :null => false
    t.text    "Details"
    t.date    "DateCash"
    t.string  "Formula"
    t.float   "Amount"
    t.integer "LinkedTransaction"
  end

  add_index "loanagenttransactions", ["Account"], :name => "Account"
  add_index "loanagenttransactions", ["LinkedTransaction"], :name => "LinkedTransaction"
  add_index "loanagenttransactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "LoanInstallments", :primary_key => "ID", :force => true do |t|
    t.integer "LoanID",  :default => 0, :null => false
    t.date    "DateDue",                :null => false
    t.float   "Amount"
  end

  add_index "loaninstallments", ["LoanID", "DateDue"], :name => "LoanID"

  create_table "LoanQuestions", :force => true do |t|
    t.integer  "Orden",                                         :null => false
    t.text     "question",                                      :null => false
    t.integer  "Grupo"
    t.string   "Type",        :limit => 20, :default => "Text", :null => false
    t.integer  "Active",      :limit => 1,  :default => 0,      :null => false
    t.integer  "IFrame",                    :default => 0,      :null => false
    t.datetime "dateCreated",                                   :null => false
  end

  create_table "LoanRequests", :primary_key => "ID", :force => true do |t|
    t.string   "Name",          :limit => 100, :default => "", :null => false
    t.string   "Contact",       :limit => 200, :default => "", :null => false
    t.string   "Location",      :limit => 200, :default => "", :null => false
    t.string   "Members"
    t.string   "Unit",          :limit => 50,  :default => "", :null => false
    t.text     "Description",                                  :null => false
    t.datetime "DateRequested",                                :null => false
    t.integer  "Answered",      :limit => 1,   :default => 0,  :null => false
  end

  create_table "LoanResponseSets", :primary_key => "ID", :force => true do |t|
    t.integer "ResponseSetID", :null => false
    t.integer "LoanID",        :null => false
  end

  add_index "loanresponsesets", ["LoanID"], :name => "LoanID", :unique => true
  add_index "loanresponsesets", ["ResponseSetID", "LoanID"], :name => "ResponseSetID", :unique => true

  create_table "LoanResponses", :primary_key => "ID", :force => true do |t|
    t.integer  "QuestionID",                         :default => 0, :null => false
    t.integer  "ResponseSetID",                      :default => 0, :null => false
    t.text     "Answer",                                            :null => false
    t.integer  "Rating"
    t.integer  "Saved",                 :limit => 1, :default => 0, :null => false
    t.datetime "Created"
    t.integer  "LoanResponsesIFrameID"
  end

  add_index "loanresponses", ["Created"], :name => "Created"
  add_index "loanresponses", ["QuestionID"], :name => "QuestionID"
  add_index "loanresponses", ["ResponseSetID", "QuestionID"], :name => "LoanID"

  create_table "LoanResponsesIFrames", :primary_key => "ID", :force => true do |t|
    t.text    "URL",                          :null => false
    t.text    "OriginalURL"
    t.integer "Height",      :default => 250, :null => false
    t.integer "Width",       :default => 400, :null => false
    t.text    "HTML"
  end

  create_table "LoanTypes", :primary_key => "ID", :force => true do |t|
    t.string "EnglishName",        :null => false
    t.string "SpanishName",        :null => false
    t.text   "EnglishDescription", :null => false
    t.text   "SpanishDescription"
  end

  create_table "Loans", :primary_key => "ID", :force => true do |t|
    t.integer "Amount"
    t.float   "Rate"
    t.integer "Length"
    t.integer "LoanType",                :limit => 1,   :default => 3,          :null => false
    t.integer "SourceDivision",                         :default => 2,          :null => false
    t.string  "Nivel",                   :limit => 200, :default => "Relacion", :null => false
    t.integer "CooperativeID",                          :default => 0,          :null => false
    t.integer "CooperativeMembers",      :limit => 2
    t.integer "PointPerson",                            :default => 0,          :null => false
    t.integer "Second"
    t.integer "RepresentativeID"
    t.date    "SigningDate"
    t.date    "FirstInterestPayment"
    t.date    "FirstPaymentDate"
    t.date    "FechaDeFinalizacion"
    t.string  "ContratoElectronico"
    t.integer "Prospective"
    t.float   "ProjectedReturn"
    t.text    "ShortDescription",                                               :null => false
    t.text    "Description"
    t.text    "ShortDescriptionEnglish"
    t.text    "DescriptionEnglish"
    t.string  "NivelPublico",            :limit => 100
  end

  add_index "loans", ["CooperativeID"], :name => "CooperativeID"
  add_index "loans", ["FechaDeFinalizacion"], :name => "FechaDeFinalizacion"
  add_index "loans", ["Nivel", "CooperativeID"], :name => "type"
  add_index "loans", ["NivelPublico"], :name => "NivelPublico"
  add_index "loans", ["PointPerson", "Prospective"], :name => "MemberID"
  add_index "loans", ["SigningDate"], :name => "SigningDate"

  create_table "Media", :primary_key => "ID", :force => true do |t|
    t.datetime "Date",                        :null => false
    t.integer  "Priority"
    t.string   "MediaPath",    :limit => 200, :null => false
    t.string   "ContextTable",                :null => false
    t.integer  "ContextID",                   :null => false
    t.integer  "MemberID",                    :null => false
    t.text     "OldCaption"
    t.text     "Description"
  end

  add_index "media", ["ContextID", "ContextTable"], :name => "ContextID"
  add_index "media", ["ContextTable"], :name => "ContextTable"
  add_index "media", ["MediaPath"], :name => "MediaPath"

  create_table "Members", :primary_key => "ID", :force => true do |t|
    t.string   "FirstName",     :limit => 150, :default => "", :null => false
    t.string   "LastName",      :limit => 150
    t.string   "Username",      :limit => 100
    t.string   "Password",      :limit => 100
    t.string   "Passcode",      :limit => 100
    t.integer  "AccessStatus",  :limit => 2
    t.string   "NationalID",    :limit => 35
    t.text     "Address"
    t.string   "City",          :limit => 200
    t.string   "Country",       :limit => 200
    t.string   "Phone",         :limit => 50
    t.string   "mobile",        :limit => 60
    t.integer  "CooperativeID"
    t.datetime "BirthDate"
    t.integer  "Payroll",       :limit => 1,   :default => 0,  :null => false
  end

  add_index "members", ["City", "Country"], :name => "City"
  add_index "members", ["LastName", "NationalID", "CooperativeID"], :name => "LastName"
  add_index "members", ["Payroll"], :name => "Payroll"
  add_index "members", ["Username"], :name => "Username"

  create_table "NotasDeAsambleas", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID", :default => 0, :null => false
    t.datetime "Date",                    :null => false
    t.text     "Note",                    :null => false
  end

  add_index "notasdeasambleas", ["MemberID", "Date"], :name => "MemberID"

  create_table "Notes", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                  :default => 0,  :null => false
    t.integer  "NotedID",                   :default => 0,  :null => false
    t.string   "NotedTable", :limit => 200, :default => "", :null => false
    t.datetime "Date",                                      :null => false
    t.text     "Note",                                      :null => false
  end

  add_index "notes", ["MemberID", "NotedID", "Date"], :name => "MemberID"
  add_index "notes", ["NotedID"], :name => "NotedID"
  add_index "notes", ["NotedTable"], :name => "NotedTable"

  create_table "Orders", :primary_key => "ID", :force => true do |t|
    t.integer  "UserID"
    t.integer  "TransactionID"
    t.float    "Donation"
    t.float    "Shipping"
    t.string   "Name"
    t.string   "ShippingAddress"
    t.string   "ShippingAddress2",          :limit => 200
    t.string   "City"
    t.string   "Province"
    t.string   "Country"
    t.string   "PostalCode"
    t.string   "EmailAddress"
    t.datetime "Date"
    t.string   "AmazonFulfilmentRequestID"
  end

  create_table "OutflowTypes", :primary_key => "ID", :force => true do |t|
    t.string "Scope",       :limit => 70, :default => "External", :null => false
    t.string "Name",        :limit => 50, :default => "",         :null => false
    t.string "Nombre"
    t.text   "Description",                                       :null => false
    t.string "FromAccount"
    t.string "ToAccount"
  end

  add_index "outflowtypes", ["Name", "ToAccount", "FromAccount"], :name => "Name", :unique => true

  create_table "ProductSubtypeCategories", :primary_key => "ID", :force => true do |t|
    t.string "Name",        :null => false
    t.text   "Description"
  end

  create_table "ProductSubtypes", :primary_key => "ID", :force => true do |t|
    t.integer "SubtypeCategoryID",        :null => false
    t.string  "ConsumerDescription",      :null => false
    t.string  "ConsumerSelectionDisplay"
    t.string  "CoopDescription"
    t.float   "DisplayOrder"
  end

  add_index "productsubtypes", ["SubtypeCategoryID", "DisplayOrder"], :name => "SubtypeCategoryID"

  create_table "Products", :primary_key => "ID", :force => true do |t|
    t.string   "ProductID",               :limit => 50,  :default => "",        :null => false
    t.string   "IDentifierUsedByCoop"
    t.string   "HarmonizedTariffCode",    :limit => 15
    t.string   "Name",                    :limit => 200
    t.string   "ProductCategory",         :limit => 100,                        :null => false
    t.string   "SizesAndColors",          :limit => 200
    t.integer  "SubtypeCategoryID"
    t.text     "Description"
    t.string   "MainImage",               :limit => 200
    t.string   "Price"
    t.integer  "CurrencyID"
    t.float    "Weight"
    t.float    "Length"
    t.float    "Width"
    t.float    "Height"
    t.float    "SpecialFundRate"
    t.float    "SpecialTaxRate"
    t.integer  "CooperativeID"
    t.datetime "DateAvailable",                                                 :null => false
    t.datetime "DateWithdrawn"
    t.string   "DisplayType",             :limit => 100, :default => "default", :null => false
    t.integer  "DisplayOrder",                           :default => 1,         :null => false
    t.string   "AmazonName",              :limit => 500
    t.string   "AmazonBulletPoints",      :limit => 505
    t.string   "AmazonClothingType"
    t.string   "AmazonMaterialFabric"
    t.string   "AmazonDepartment",        :limit => 400
    t.string   "AmazonStyleKeyword",      :limit => 400
    t.string   "AmazonOccasionLifestyle", :limit => 400
  end

  add_index "products", ["AmazonClothingType"], :name => "AmazonClothingType"
  add_index "products", ["CooperativeID", "DisplayOrder"], :name => "coopID_displayOrder"
  add_index "products", ["ProductID"], :name => "ProductID"

  create_table "ProductsOrdered", :primary_key => "ID", :force => true do |t|
    t.integer  "ProductSubtype",        :default => 0, :null => false
    t.string   "ProductID"
    t.integer  "OrderID"
    t.integer  "ShipmentID"
    t.float    "Price"
    t.integer  "Quantity"
    t.string   "Size"
    t.string   "Color"
    t.string   "Characteristics"
    t.float    "FundDonation"
    t.float    "Taxes"
    t.datetime "DateCoopGivenOrder"
    t.datetime "DateCoopPaid"
    t.datetime "DateTaxesPaid"
    t.float    "CreditTransactionCost"
  end

  add_index "productsordered", ["OrderID"], :name => "OrderID"
  add_index "productsordered", ["ProductID"], :name => "ProductID"
  add_index "productsordered", ["ShipmentID"], :name => "ShipmentID"

  create_table "ProgressMetrics", :primary_key => "ID", :force => true do |t|
    t.integer "Level",                    :null => false
    t.string  "EnglishDisplayWithEvents", :null => false
    t.string  "SpanishDisplayWithEvents", :null => false
    t.string  "EnglishDisplayContinuous", :null => false
    t.string  "SpanishDisplayContinuous", :null => false
  end

  create_table "ProjectEvents", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                                                :null => false
    t.integer  "ProjectID",                                               :null => false
    t.string   "ProjectTable",               :default => "BasicProjects", :null => false
    t.string   "Summary",                                                 :null => false
    t.text     "Details"
    t.datetime "Date",                                                    :null => false
    t.integer  "Finalized",    :limit => 1,  :default => 0,               :null => false
    t.date     "Completed"
    t.datetime "ModifiedDate",                                            :null => false
    t.string   "Type",         :limit => 35,                              :null => false
  end

  add_index "projectevents", ["Date"], :name => "date"
  add_index "projectevents", ["ProjectID"], :name => "ProjectID"

  create_table "ProjectLogs", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                          :default => 0,               :null => false
    t.integer  "ProjectID",                                                      :null => false
    t.string   "ProjectTable",                      :default => "BasicProjects", :null => false
    t.integer  "PasoID",                            :default => 1
    t.datetime "Date",                                                           :null => false
    t.string   "Progress",            :limit => 30, :default => "On time",       :null => false
    t.integer  "ProgressMetric",      :limit => 1,  :default => 0,               :null => false
    t.string   "Explanation"
    t.text     "DetailedExplanation"
    t.text     "NotasPrivadas"
    t.text     "AdditionalNotes"
  end

  add_index "projectlogs", ["MemberID", "ProjectID", "Date"], :name => "MemberID"
  add_index "projectlogs", ["ProjectID"], :name => "NotedID"

  create_table "QuestionableTransactions", :primary_key => "ID", :force => true do |t|
    t.integer "GroupTransactionID"
    t.integer "Account",                :limit => 2,  :default => 0, :null => false
    t.integer "MemberID",                             :default => 2
    t.integer "Loan",                   :limit => 2
    t.integer "CheckID"
    t.integer "TransactionType",        :limit => 1
    t.integer "InflowType",             :limit => 1
    t.integer "OutflowType",            :limit => 1
    t.text    "Description",                                         :null => false
    t.string  "TipoDeDocumento"
    t.string  "NumeroDeDocumento"
    t.text    "Details"
    t.integer "FiltradoPorSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.integer "SolamenteEnSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.date    "DateAccrual"
    t.date    "DateCash"
    t.string  "Formula"
    t.float   "Amount",                 :limit => 10,                :null => false
    t.float   "AmountFixed",            :limit => 10
    t.float   "Credit",                 :limit => 10
    t.float   "Debit",                  :limit => 10
  end

  add_index "questionabletransactions", ["Account"], :name => "Account"
  add_index "questionabletransactions", ["CheckID"], :name => "CheckID"
  add_index "questionabletransactions", ["DateCash"], :name => "DateCash"
  add_index "questionabletransactions", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "questionabletransactions", ["Loan"], :name => "Loan"
  add_index "questionabletransactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "Repayments", :primary_key => "ID", :force => true do |t|
    t.integer  "LoanID",                   :default => 0, :null => false
    t.datetime "DateDue",                                 :null => false
    t.datetime "DatePaid"
    t.integer  "AmountDue",                :default => 0, :null => false
    t.integer  "AmountPaid"
    t.integer  "InterestSinceLastPayment"
    t.date     "DateRefinanced"
  end

  add_index "repayments", ["LoanID", "DateDue"], :name => "LoanID"

  create_table "Shipments", :primary_key => "ID", :force => true do |t|
    t.integer  "OrderID",                                  :default => 0, :null => false
    t.string   "TrackingNumber"
    t.string   "Carrier",                   :limit => 100
    t.datetime "DateTrackingNumberEntered"
    t.date     "ShipmentDate"
    t.float    "Cost"
    t.text     "Notes"
  end

  add_index "shipments", ["OrderID", "TrackingNumber"], :name => "OrderID", :unique => true

  create_table "ShippingAddresses", :primary_key => "ID", :force => true do |t|
    t.integer "UserID"
    t.integer "DefaultAddress"
    t.string  "Name"
    t.string  "Street1"
    t.string  "Street2"
    t.string  "City"
    t.string  "Province"
    t.string  "Country"
    t.string  "PostalCode"
  end

  add_index "shippingaddresses", ["UserID", "DefaultAddress"], :name => "UserID_default"

  create_table "StoreTransactions", :primary_key => "ID", :force => true do |t|
    t.string   "Response"
    t.string   "ErrorMessage"
    t.integer  "UserID"
    t.string   "AccountNumber"
    t.string   "ExpMonth"
    t.string   "ExpYear"
    t.string   "CVV2",           :limit => 5
    t.string   "Name"
    t.string   "BillingAddress"
    t.string   "PostalCode"
    t.string   "Country"
    t.float    "Amount"
    t.datetime "Date"
  end

  create_table "StoreUserCreditCards", :primary_key => "ID", :force => true do |t|
    t.integer "UserID"
    t.integer "DefaultCard"
    t.string  "FirstName"
    t.string  "LastName"
    t.string  "Type"
    t.string  "AccountNumber"
    t.string  "ExpMonth"
    t.string  "ExpYear"
    t.string  "CVV2"
    t.string  "Street1"
    t.string  "Street2"
    t.string  "City"
    t.string  "Province"
    t.string  "Country"
    t.string  "PostalCode"
  end

  add_index "storeusercreditcards", ["UserID", "DefaultCard"], :name => "UserID"

  create_table "StoreUserLog", :primary_key => "ID", :force => true do |t|
    t.datetime "Date",                      :null => false
    t.string   "TrackingID", :limit => 20,  :null => false
    t.string   "UserEmail",  :limit => 50
    t.string   "URL",        :limit => 200, :null => false
    t.string   "Query",                     :null => false
  end

  add_index "storeuserlog", ["TrackingID"], :name => "TrackingID"
  add_index "storeuserlog", ["UserEmail"], :name => "UserEmail"

  create_table "StoreUsers", :primary_key => "ID", :force => true do |t|
    t.string   "Email"
    t.string   "Password"
    t.string   "Crypt"
    t.datetime "StartDate"
  end

  add_index "storeusers", ["Email"], :name => "Email", :unique => true

  create_table "TransactionTypes", :primary_key => "ID", :force => true do |t|
    t.string "Scope",       :limit => 70, :default => "External", :null => false
    t.string "Name",        :limit => 50, :default => "",         :null => false
    t.string "Nombre"
    t.text   "Description",                                       :null => false
    t.string "FromAccount"
    t.string "ToAccount"
  end

  add_index "transactiontypes", ["Name", "FromAccount", "ToAccount"], :name => "Name", :unique => true

  create_table "Transactions", :primary_key => "ID", :force => true do |t|
    t.integer "GroupTransactionID"
    t.integer "Account",                :limit => 2,  :default => 0, :null => false
    t.integer "MemberID",                             :default => 2
    t.integer "Loan",                   :limit => 2
    t.integer "CheckID"
    t.integer "TransactionType",        :limit => 1
    t.integer "InflowType",             :limit => 1
    t.integer "OutflowType",            :limit => 1
    t.text    "Description",                                         :null => false
    t.string  "TipoDeDocumento"
    t.string  "NumeroDeDocumento"
    t.text    "Details"
    t.integer "FiltradoPorSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.integer "SolamenteEnSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.date    "DateAccrual"
    t.date    "DateCash"
    t.string  "Formula"
    t.float   "Amount",                 :limit => 10,                :null => false
    t.float   "AmountFixed",            :limit => 10
    t.float   "Credit",                 :limit => 10
    t.float   "Debit",                  :limit => 10
  end

  add_index "transactions", ["Account"], :name => "Account"
  add_index "transactions", ["CheckID"], :name => "CheckID"
  add_index "transactions", ["DateCash"], :name => "DateCash"
  add_index "transactions", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "transactions", ["Loan"], :name => "Loan"
  add_index "transactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "TransactionsArchive", :primary_key => "ID", :force => true do |t|
    t.integer "GroupTransactionID"
    t.integer "Account",                :limit => 2,  :default => 0, :null => false
    t.integer "MemberID",                             :default => 2
    t.integer "Loan",                   :limit => 2
    t.integer "CheckID"
    t.integer "TransactionType",        :limit => 1
    t.integer "InflowType",             :limit => 1
    t.integer "OutflowType",            :limit => 1
    t.text    "Description",                                         :null => false
    t.string  "TipoDeDocumento"
    t.string  "NumeroDeDocumento"
    t.text    "Details"
    t.integer "FiltradoPorSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.integer "SolamenteEnSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.date    "DateAccrual"
    t.date    "DateCash"
    t.string  "Formula"
    t.float   "Amount",                 :limit => 10,                :null => false
    t.float   "AmountFixed",            :limit => 10
    t.float   "Credit",                 :limit => 10
    t.float   "Debit",                  :limit => 10
  end

  add_index "transactionsarchive", ["Account"], :name => "Account"
  add_index "transactionsarchive", ["CheckID"], :name => "CheckID"
  add_index "transactionsarchive", ["DateCash"], :name => "DateCash"
  add_index "transactionsarchive", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "transactionsarchive", ["Loan"], :name => "Loan"
  add_index "transactionsarchive", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "TransactionsHold", :primary_key => "ID", :force => true do |t|
    t.integer "GroupTransactionID"
    t.integer "Account",                :limit => 2,  :default => 0, :null => false
    t.integer "MemberID",                             :default => 2
    t.integer "Loan",                   :limit => 2
    t.integer "CheckID"
    t.integer "TransactionType",        :limit => 1
    t.integer "InflowType",             :limit => 1
    t.integer "OutflowType",            :limit => 1
    t.text    "Description",                                         :null => false
    t.string  "TipoDeDocumento"
    t.string  "NumeroDeDocumento"
    t.text    "Details"
    t.integer "FiltradoPorSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.integer "SolamenteEnSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.date    "DateAccrual"
    t.date    "DateCash"
    t.string  "Formula"
    t.float   "Amount",                 :limit => 10,                :null => false
    t.float   "AmountFixed",            :limit => 10
    t.float   "Credit",                 :limit => 10
    t.float   "Debit",                  :limit => 10
  end

  add_index "transactionshold", ["Account"], :name => "Account"
  add_index "transactionshold", ["CheckID"], :name => "CheckID"
  add_index "transactionshold", ["DateCash"], :name => "DateCash"
  add_index "transactionshold", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "transactionshold", ["Loan"], :name => "Loan"
  add_index "transactionshold", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "TransactionsLog", :primary_key => "ID", :force => true do |t|
    t.integer  "User",                                                :null => false
    t.integer  "TransactionID",                                       :null => false
    t.string   "Action",                                              :null => false
    t.datetime "ChangeDate",                                          :null => false
    t.integer  "AmountFrom"
    t.integer  "GroupTransactionID"
    t.integer  "Account",                :limit => 2,  :default => 0, :null => false
    t.integer  "MemberID",                             :default => 2
    t.integer  "Loan",                   :limit => 2
    t.integer  "CheckID"
    t.integer  "TransactionType",        :limit => 1
    t.integer  "InflowType",             :limit => 1
    t.integer  "OutflowType",            :limit => 1
    t.text     "Description",                                         :null => false
    t.string   "TipoDeDocumento"
    t.string   "NumeroDeDocumento"
    t.text     "Details"
    t.integer  "FiltradoPorSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.integer  "SolamenteEnSistemaEleo", :limit => 1,  :default => 0, :null => false
    t.date     "DateAccrual"
    t.date     "DateCash"
    t.string   "Formula"
    t.float    "Amount",                 :limit => 10,                :null => false
    t.float    "AmountFixed",            :limit => 10
    t.float    "Credit",                 :limit => 10
    t.float    "Debit",                  :limit => 10
  end

  add_index "transactionslog", ["Account"], :name => "Account"
  add_index "transactionslog", ["CheckID"], :name => "CheckID"
  add_index "transactionslog", ["DateCash"], :name => "DateCash"
  add_index "transactionslog", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "transactionslog", ["Loan"], :name => "Loan"
  add_index "transactionslog", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "Translations", :primary_key => "ID", :force => true do |t|
    t.integer "Language",                         :null => false
    t.integer "RemoteID",                         :null => false
    t.string  "RemoteTable",       :limit => 200, :null => false
    t.string  "RemoteColumnName",  :limit => 200, :null => false
    t.text    "TranslatedContent",                :null => false
  end

  add_index "translations", ["RemoteID"], :name => "RemoteID"

  create_table "VendorOrders", :primary_key => "ID", :force => true do |t|
    t.datetime "DateRequested"
    t.datetime "DateReceived"
    t.string   "ProductID",      :limit => 100,                :null => false
    t.integer  "ProductSubtype",                :default => 0, :null => false
    t.integer  "TransactionID"
    t.integer  "Quantity",                                     :null => false
    t.float    "Price",                                        :null => false
    t.text     "Notes"
  end

  create_table "WorkChangeLog", :primary_key => "ID", :force => true do |t|
    t.integer  "WorkLogID",    :null => false
    t.integer  "MemberID",     :null => false
    t.datetime "StartTime"
    t.datetime "EndTime"
    t.string   "Client"
    t.datetime "ModifiedTime", :null => false
  end

  create_table "WorkLog", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                           :null => false
    t.datetime "StartTime",                          :null => false
    t.datetime "EndTime"
    t.string   "StartClient"
    t.string   "EndClient"
    t.string   "ActivityType",        :limit => 100
    t.integer  "ProjectID"
    t.integer  "PasoID"
    t.string   "ActivityCategory"
    t.text     "ActivityDescription"
  end

  add_index "worklog", ["ActivityCategory"], :name => "ActivityCategory"

  create_table "WorkerVacation", :primary_key => "ID", :force => true do |t|
    t.integer "MemberID",  :null => false
    t.date    "StartDate", :null => false
    t.date    "EndDate",   :null => false
  end

  add_index "workervacation", ["EndDate"], :name => "EndDate"
  add_index "workervacation", ["MemberID"], :name => "MemberID"
  add_index "workervacation", ["StartDate"], :name => "StartDate"

  create_table "mailinglist", :force => true do |t|
    t.string   "firstname", :limit => 200, :default => "", :null => false
    t.string   "lastname",  :limit => 200, :default => "", :null => false
    t.string   "email",     :limit => 200, :default => "", :null => false
    t.datetime "startdate",                                :null => false
  end

  create_table "test", :primary_key => "ID", :force => true do |t|
    t.string   "Test",    :null => false
    t.datetime "thedate"
  end

  create_table "todo", :primary_key => "ID", :force => true do |t|
    t.integer "Priority",                  :default => 0,  :null => false
    t.string  "STATUS",      :limit => 30, :default => "", :null => false
    t.integer "PointPerson"
    t.integer "Second"
    t.date    "Modified",                                  :null => false
    t.text    "Description",                               :null => false
  end

  add_index "todo", ["Priority"], :name => "Priority"

  create_table "user_loan_contributions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "loan_id"
    t.decimal  "amount",     :precision => 12, :scale => 2
    t.decimal  "balance",    :precision => 12, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "user_loan_contributions", ["loan_id"], :name => "index_user_loan_contributions_on_loan_id"
  add_index "user_loan_contributions", ["user_id"], :name => "index_user_loan_contributions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                 :default => "", :null => false
    t.string   "encrypted_password",                                    :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "balance",                :precision => 12, :scale => 2
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
