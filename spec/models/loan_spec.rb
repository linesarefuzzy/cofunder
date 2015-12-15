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
      context 'with country' do
        before do
          @country = create(:country, name: 'Argentina')
          @division = create(:division, country: @country.name)
          @loan = create(:loan, source_division: @division.id)
        end

        it 'gets country' do
          expect(@loan.country).to eq @country
          expect(@loan.country.name).to eq 'Argentina'
        end
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
      let(:loan) do
        create(
          :loan,
          cooperative_id: create(:cooperative, city: 'Ann Arbor').id,
          source_division: create(:division, country: create(:country, name: 'United States').name).id
        )
      end
      it 'returns city and country' do
        expect(loan.location).to eq "Ann Arbor, United States"
      end

      context 'without city' do
        let(:loan) { create(:loan, cooperative: create(:cooperative, city: "")) }

        it 'returns country' do
          expect(loan.location).to eq loan.country.name
        end
      end
    end

    describe '.signing_date_long' do
      let(:loan) { create(:loan, signing_date: Date.civil(2011, 11, 11))}
      it 'returns long formatted date' do
        expect(loan.signing_date_long).to eq "November 11, 2011"
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
