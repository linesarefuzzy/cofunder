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

ActiveRecord::Schema.define(:version => 20130309032549) do

  create_table "AccountClasses", :primary_key => "ID", :force => true do |t|
    t.string "ClassID",      :null => false
    t.string "SuperClassID"
    t.string "Name",         :null => false
    t.string "Nombre",       :null => false
    t.text   "Description"
  end

  add_index "AccountClasses", ["ClassID"], :name => "ClassID"
  add_index "AccountClasses", ["SuperClassID"], :name => "SuperClassID"

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

  add_index "Accounts", ["DivisionID"], :name => "AccountOwnerID"
  add_index "Accounts", ["ExternalAccountingID", "DivisionID"], :name => "ExternalAccountingID", :unique => true
  add_index "Accounts", ["Name", "DivisionID"], :name => "NameDivision", :unique => true

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

  add_index "BasicProjects", ["Coordinator"], :name => "MemberID"
  add_index "BasicProjects", ["Nivel"], :name => "type"
  add_index "BasicProjects", ["StartDate"], :name => "SigningDate"

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
    t.string   "Name",                    :limit => 250,                 :null => false
    t.string   "Alias",                   :limit => 200
    t.text     "Address"
    t.string   "City",                    :limit => 200, :default => "", :null => false
    t.string   "Country",                 :limit => 200, :default => "", :null => false
    t.string   "web"
    t.text     "Contact"
    t.string   "Ownership",               :limit => 250
    t.datetime "OwnershipChangeDate"
    t.integer  "Recuperada",              :limit => 1,   :default => 0,  :null => false
    t.string   "Sector",                  :limit => 200
    t.string   "Industry",                :limit => 200
    t.string   "Source",                  :limit => 250
  end

  add_index "Cooperatives", ["Name"], :name => "Name"
  add_index "Cooperatives", ["Ownership", "OwnershipChangeDate"], :name => "ownership"
  add_index "Cooperatives", ["Sector", "Industry"], :name => "sector"

  create_table "Currencies", :primary_key => "ID", :force => true do |t|
    t.string  "Name",            :limit => 50, :default => "",          :null => false
    t.string  "Symbol",          :limit => 20, :default => "",          :null => false
    t.text    "Description",                                            :null => false
    t.integer "DefaultCurrency", :limit => 1,  :default => 0,           :null => false
    t.string  "Country",                       :default => "Argentina", :null => false
    t.float   "ExchangeRate",                  :default => 1.0,         :null => false
  end

  add_index "Currencies", ["DefaultCurrency"], :name => "Default"

  create_table "Divisions", :primary_key => "ID", :force => true do |t|
    t.string  "Name",                           :default => "",          :null => false
    t.string  "ExternalName"
    t.integer "AccountDivision",                :default => 2,           :null => false
    t.integer "SuperDivision"
    t.string  "Country",         :limit => 120, :default => "Argentina", :null => false
    t.text    "Description",                                             :null => false
  end

  add_index "Divisions", ["Name"], :name => "Name"

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

  add_index "Inventory", ["Current"], :name => "Current"

  create_table "Languages", :primary_key => "ID", :force => true do |t|
    t.string  "Code",     :limit => 2,   :null => false
    t.string  "Name",     :limit => 200, :null => false
    t.integer "Priority", :limit => 2,   :null => false
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

  add_index "LoanAgentTransactions", ["Account"], :name => "Account"
  add_index "LoanAgentTransactions", ["LinkedTransaction"], :name => "LinkedTransaction"
  add_index "LoanAgentTransactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "LoanInstallments", :primary_key => "ID", :force => true do |t|
    t.integer "LoanID",         :default => 0, :null => false
    t.date    "DateDue",                       :null => false
    t.integer "CapitalCuota",   :default => 0, :null => false
    t.integer "InterestCuota"
    t.date    "DateRefinanced"
  end

  add_index "LoanInstallments", ["LoanID", "DateDue"], :name => "LoanID"

  create_table "LoanQuestions", :force => true do |t|
    t.integer  "Orden",                                         :null => false
    t.text     "question",                                      :null => false
    t.integer  "Grupo"
    t.string   "Type",        :limit => 20, :default => "Text", :null => false
    t.integer  "Active",      :limit => 1,  :default => 0,      :null => false
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

  add_index "LoanResponseSets", ["LoanID"], :name => "LoanID", :unique => true
  add_index "LoanResponseSets", ["ResponseSetID", "LoanID"], :name => "ResponseSetID", :unique => true

  create_table "LoanResponses", :primary_key => "ID", :force => true do |t|
    t.integer  "QuestionID",                 :default => 0, :null => false
    t.integer  "ResponseSetID",              :default => 0, :null => false
    t.text     "Answer",                                    :null => false
    t.integer  "Rating"
    t.integer  "Saved",         :limit => 1, :default => 0, :null => false
    t.datetime "Created"
  end

  add_index "LoanResponses", ["Created"], :name => "Created"
  add_index "LoanResponses", ["QuestionID"], :name => "QuestionID"
  add_index "LoanResponses", ["ResponseSetID", "QuestionID"], :name => "LoanID"

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

  add_index "Loans", ["CooperativeID"], :name => "CooperativeID"
  add_index "Loans", ["FechaDeFinalizacion"], :name => "FechaDeFinalizacion"
  add_index "Loans", ["Nivel", "CooperativeID"], :name => "type"
  add_index "Loans", ["NivelPublico"], :name => "NivelPublico"
  add_index "Loans", ["PointPerson", "Prospective"], :name => "MemberID"
  add_index "Loans", ["SigningDate"], :name => "SigningDate"

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

  add_index "Media", ["ContextID", "ContextTable"], :name => "ContextID"
  add_index "Media", ["ContextTable"], :name => "ContextTable"
  add_index "Media", ["MediaPath"], :name => "MediaPath"

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

  add_index "Members", ["City", "Country"], :name => "City"
  add_index "Members", ["LastName", "NationalID", "CooperativeID"], :name => "LastName"
  add_index "Members", ["Payroll"], :name => "Payroll"
  add_index "Members", ["Username"], :name => "Username"

  create_table "NotasDeAsambleas", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID", :default => 0, :null => false
    t.datetime "Date",                    :null => false
    t.text     "Note",                    :null => false
  end

  add_index "NotasDeAsambleas", ["MemberID", "Date"], :name => "MemberID"

  create_table "Notes", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                  :default => 0,  :null => false
    t.integer  "NotedID",                   :default => 0,  :null => false
    t.string   "NotedTable", :limit => 200, :default => "", :null => false
    t.datetime "Date",                                      :null => false
    t.text     "Note",                                      :null => false
  end

  add_index "Notes", ["MemberID", "NotedID", "Date"], :name => "MemberID"
  add_index "Notes", ["NotedID"], :name => "NotedID"
  add_index "Notes", ["NotedTable"], :name => "NotedTable"

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

  add_index "OutflowTypes", ["Name", "ToAccount", "FromAccount"], :name => "Name", :unique => true

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

  add_index "ProductSubtypes", ["SubtypeCategoryID", "DisplayOrder"], :name => "SubtypeCategoryID"

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

  add_index "Products", ["AmazonClothingType"], :name => "AmazonClothingType"
  add_index "Products", ["CooperativeID", "DisplayOrder"], :name => "coopID_displayOrder"
  add_index "Products", ["ProductID"], :name => "ProductID"

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

  add_index "ProductsOrdered", ["OrderID"], :name => "OrderID"
  add_index "ProductsOrdered", ["ProductID"], :name => "ProductID"
  add_index "ProductsOrdered", ["ShipmentID"], :name => "ShipmentID"

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

  add_index "ProjectEvents", ["Date"], :name => "date"
  add_index "ProjectEvents", ["ProjectID"], :name => "ProjectID"

  create_table "ProjectLogs", :primary_key => "ID", :force => true do |t|
    t.integer  "MemberID",                          :default => 0,               :null => false
    t.integer  "ProjectID",                                                      :null => false
    t.string   "ProjectTable",                      :default => "BasicProjects", :null => false
    t.integer  "PasoID",                            :default => 1
    t.datetime "Date",                                                           :null => false
    t.string   "Progress",            :limit => 30, :default => "On time",       :null => false
    t.string   "Explanation"
    t.text     "DetailedExplanation"
    t.text     "NotasPrivadas"
    t.text     "AdditionalNotes"
  end

  add_index "ProjectLogs", ["MemberID", "ProjectID", "Date"], :name => "MemberID"
  add_index "ProjectLogs", ["ProjectID"], :name => "NotedID"

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

  add_index "QuestionableTransactions", ["Account"], :name => "Account"
  add_index "QuestionableTransactions", ["CheckID"], :name => "CheckID"
  add_index "QuestionableTransactions", ["DateCash"], :name => "DateCash"
  add_index "QuestionableTransactions", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "QuestionableTransactions", ["Loan"], :name => "Loan"
  add_index "QuestionableTransactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "Repayments", :primary_key => "ID", :force => true do |t|
    t.integer  "LoanID",                   :default => 0, :null => false
    t.datetime "DateDue",                                 :null => false
    t.datetime "DatePaid"
    t.integer  "AmountDue",                :default => 0, :null => false
    t.integer  "AmountPaid"
    t.integer  "InterestSinceLastPayment"
    t.date     "DateRefinanced"
  end

  add_index "Repayments", ["LoanID", "DateDue"], :name => "LoanID"

  create_table "Shipments", :primary_key => "ID", :force => true do |t|
    t.integer  "OrderID",                                  :default => 0, :null => false
    t.string   "TrackingNumber"
    t.string   "Carrier",                   :limit => 100
    t.datetime "DateTrackingNumberEntered"
    t.date     "ShipmentDate"
    t.float    "Cost"
    t.text     "Notes"
  end

  add_index "Shipments", ["OrderID", "TrackingNumber"], :name => "OrderID", :unique => true

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

  add_index "ShippingAddresses", ["UserID", "DefaultAddress"], :name => "UserID_default"

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

  add_index "StoreUserCreditCards", ["UserID", "DefaultCard"], :name => "UserID"

  create_table "StoreUserLog", :primary_key => "ID", :force => true do |t|
    t.datetime "Date",                      :null => false
    t.string   "TrackingID", :limit => 20,  :null => false
    t.string   "UserEmail",  :limit => 50
    t.string   "URL",        :limit => 200, :null => false
    t.string   "Query",                     :null => false
  end

  add_index "StoreUserLog", ["TrackingID"], :name => "TrackingID"
  add_index "StoreUserLog", ["UserEmail"], :name => "UserEmail"

  create_table "StoreUsers", :primary_key => "ID", :force => true do |t|
    t.string   "Email"
    t.string   "Password"
    t.string   "Crypt"
    t.datetime "StartDate"
  end

  add_index "StoreUsers", ["Email"], :name => "Email", :unique => true

  create_table "TransactionTypes", :primary_key => "ID", :force => true do |t|
    t.string "Scope",       :limit => 70, :default => "External", :null => false
    t.string "Name",        :limit => 50, :default => "",         :null => false
    t.string "Nombre"
    t.text   "Description",                                       :null => false
    t.string "FromAccount"
    t.string "ToAccount"
  end

  add_index "TransactionTypes", ["Name", "FromAccount", "ToAccount"], :name => "Name", :unique => true

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

  add_index "Transactions", ["Account"], :name => "Account"
  add_index "Transactions", ["CheckID"], :name => "CheckID"
  add_index "Transactions", ["DateCash"], :name => "DateCash"
  add_index "Transactions", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "Transactions", ["Loan"], :name => "Loan"
  add_index "Transactions", ["OutflowType", "DateCash"], :name => "ExpenditureType"

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

  add_index "TransactionsArchive", ["Account"], :name => "Account"
  add_index "TransactionsArchive", ["CheckID"], :name => "CheckID"
  add_index "TransactionsArchive", ["DateCash"], :name => "DateCash"
  add_index "TransactionsArchive", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "TransactionsArchive", ["Loan"], :name => "Loan"
  add_index "TransactionsArchive", ["OutflowType", "DateCash"], :name => "ExpenditureType"

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

  add_index "TransactionsHold", ["Account"], :name => "Account"
  add_index "TransactionsHold", ["CheckID"], :name => "CheckID"
  add_index "TransactionsHold", ["DateCash"], :name => "DateCash"
  add_index "TransactionsHold", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "TransactionsHold", ["Loan"], :name => "Loan"
  add_index "TransactionsHold", ["OutflowType", "DateCash"], :name => "ExpenditureType"

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

  add_index "TransactionsLog", ["Account"], :name => "Account"
  add_index "TransactionsLog", ["CheckID"], :name => "CheckID"
  add_index "TransactionsLog", ["DateCash"], :name => "DateCash"
  add_index "TransactionsLog", ["GroupTransactionID"], :name => "GroupTransactionID"
  add_index "TransactionsLog", ["Loan"], :name => "Loan"
  add_index "TransactionsLog", ["OutflowType", "DateCash"], :name => "ExpenditureType"

  create_table "Translations", :primary_key => "ID", :force => true do |t|
    t.integer "Language",                         :null => false
    t.integer "RemoteID",                         :null => false
    t.string  "RemoteTable",       :limit => 200, :null => false
    t.string  "RemoteColumnName",  :limit => 200, :null => false
    t.text    "TranslatedContent",                :null => false
  end

  add_index "Translations", ["RemoteID"], :name => "RemoteID"

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

  add_index "WorkLog", ["ActivityCategory"], :name => "ActivityCategory"

  create_table "WorkerVacation", :primary_key => "ID", :force => true do |t|
    t.integer "MemberID",  :null => false
    t.date    "StartDate", :null => false
    t.date    "EndDate",   :null => false
  end

  add_index "WorkerVacation", ["EndDate"], :name => "EndDate"
  add_index "WorkerVacation", ["MemberID"], :name => "MemberID"
  add_index "WorkerVacation", ["StartDate"], :name => "StartDate"

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

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
