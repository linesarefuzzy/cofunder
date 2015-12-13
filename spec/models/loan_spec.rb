require 'rails_helper'

describe Loan, :type => :model do
  it_should_behave_like 'translatable', ['Description', 'ShortDescription']
  it_should_behave_like 'mediable'

  it 'has a valid factory' do
    expect(create(:loan)).to be_valid
  end

  context 'model methods' do
    let(:loan) { create(:loan) }

    describe '.name' do
      context 'with cooperative' do
        it 'uses cooperative name' do
          expect(loan.name).to eq I18n.t :project_with, name: loan.cooperative.name
        end
      end

      context 'without cooperative' do
        let(:loan) { create(:loan, cooperative: nil) }
        it 'uses project id' do
          pending('is not currently possible given DB constraints')
          expect(loan.name).to eq I18n.t :project_id, id: loan.id.to_s
        end
      end
    end

    describe '.country' do
      it 'gets country' do
        expect(loan.country).to eq Country.where(name: loan.division.super_division.country).first
      end

      context 'without country' do
        before do
          @division = create(:division)
          @loan = create(:loan, source_division: @division.id)
          @us = create(:country, name: "United States")
        end
        it 'gets united states' do
          expect(@loan.country).to eq @us
        end
      end
    end

    describe '.location' do
      it 'returns city and country' do
        expect(loan.location).to eq "#{loan.cooperative.city}, #{loan.country.name}"
      end

      context 'without city' do
        let(:loan) { create(:loan, cooperative: create(:cooperative, city: "")) }

        it 'returns country' do
          expect(loan.location).to eq loan.country.name
        end
      end
    end

    describe '.signing_date_long' do
      it 'returns long formatted date' do
        expect(loan.signing_date_long).to eq I18n.l(loan.signing_date, format: :long)
      end
    end

    describe '.status' do
      context 'with active loan' do
        let(:loan) { create(:loan, :active) }
        it 'returns active' do
          expect(loan.status).to eq I18n.t(:loan_active)
        end
      end

      context 'with completed loan' do
        let(:loan) { create(:loan, :completed) }
        it 'returns complete' do
          expect(loan.status).to eq I18n.t(:loan_completed)
        end
      end
    end
  end
end
