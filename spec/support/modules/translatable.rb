shared_examples_for 'translatable' do |column_names|
  let(:translatable_model) { create(described_class.to_s.underscore) }
  context 'with translations' do
    before do
      column_names.each do |column_name|
        @translations ||= {}
        @translations[column_name] = create(:translation, remote_column_name: column_name, remote_table: translatable_model.class.table_name, remote_id: translatable_model.id)
      end
    end


    it 'should give translation' do
      column_names.each do |column_name|
        translation = translatable_model.translation(column_name)
        expect(translation).to eq @translations[column_name]
      end
    end

    it 'should have method for column name that fetches translation' do
      column_names.each do |column_name|
        method = column_name.underscore.downcase.to_sym
        t = translatable_model.try(method)
        expect(t).to be_a Translation
      end
    end
  end
end
