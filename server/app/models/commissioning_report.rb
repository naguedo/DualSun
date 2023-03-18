class CommissioningReport < ApplicationRecord
  has_many :panels, dependent: :destroy

  enum option: { photovoltaic: 0, hybrid: 1 }

  validates :siren, presence: true, 
                    format: { with: /\A(?!(0000000|999999999))\d{9}\z/, 
                              message: "SIREN number is not valid" }

  validates :phone, presence: true,
                    format: { with: /\A(0|\+33)[\s\-]?[1-9][\s\-]?(\d{2}[\s\-]?){4}\z/,
                              message: "Phone number is not valid" }

  validates :email, presence: true, 
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, 
                              message: "Email is not valid" }

  validates :company_name, presence: true
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true, 
                  length: { is: 5 }, 
                  numericality: { only_integer: true }
  validates :installed_on, presence: true
  
  validates :option, presence: true, inclusion: { in: CommissioningReport.options.keys }

  accepts_nested_attributes_for :panels, reject_if: :all_blank, allow_destroy: true

  validates :panels, presence: { message: "Must have at least one panel" }
end