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

    describe '.project_events' do
      let!(:loan) { create(:loan) }
      let!(:project_events) do
        project_events = []
        project_events << create_list(:project_event, 2, :past, :completed, :with_logs, :for_loan, loan_id: loan.id)
        project_events << create_list(:project_event, 8, :past, :for_loan, loan_id: loan.id)
        project_events << create_list(:project_event, 2, :future, :for_loan, loan_id: loan.id)
        project_events << create_list(:project_event, 2, :past, :completed, :for_loan, loan_id: loan.id)
        project_events << create_list(:project_event, 2, :past, :with_logs, :for_loan, loan_id: loan.id)
        project_events.flatten
      end

      it 'it should return all future events and past events if they are complete or have logs' do
        # puts project_events.awesome_inspect
        events = loan.project_events
        expect(events.size).to eq 8
        events.each do |event|
          if event.logs.empty? && !event.completed
            expect(event.date).to be > Date.today
          end
        end
      end
    end

    describe '.featured_pictures' do
      let(:loan) { create(:loan, :with_loan_media, :with_coop_media) }

      it 'has a default limit of 1' do
        expect(loan.featured_pictures.size).to eq 1
      end

      it 'respects the limit for larger limits' do
        expect(loan.featured_pictures(limit = 3).size).to eq 3
      end

      describe 'sorting' do
        let!(:loan) { create(:loan, :with_one_project_event) }
        let!(:loan_pics) { create_list(:media, 2, context_table: 'Loans', context_id: loan.id).sort_by(&:media_path) }
        let!(:coop_pics) { create_list(:media, 2, context_table: 'Cooperatives', context_id: loan.cooperative.id).sort_by(&:media_path) }
        let!(:log_pics) do
          log_pics = []
          loan.logs.each do |log|
            log_pics << create_list(:media, 2, context_table: 'ProjectLogs', context_id: log.id).sort_by(&:media_path)
          end
          log_pics.flatten
        end

        it 'sorts using first coop pic, loan pics, log pics, and fills in with coop pics' do
          sorted_pics = [coop_pics.first, loan_pics.first, loan_pics.last, log_pics, coop_pics.last].flatten
          expect(loan.featured_pictures(limit = 10)).to eq sorted_pics
        end
      end

    end

  end
end
