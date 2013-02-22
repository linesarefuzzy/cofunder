module TranslationModule
  def get_translation(table_name, column_name, id, language_code='EN')
    translations = Translation.where(
      :RemoteTable => table_name,
      :RemoteColumnName => column_name,
      :RemoteID => id
    )
    begin
      # content = translations.joins(:Language).where(:languages => {:Code => language_code}).first.TranslatedContent
      content = translations.joins(:Language).where('languages.Code' => language_code).first.TranslatedContent
    rescue NoMethodError
      begin
        content = translations.joins(:Language).order('languages.Priority').first.TranslatedContent
      rescue NoMethodError
        return ''
      end
    end
    return content
  end
end