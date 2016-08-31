module MessageConcerns
  extend ActiveSupport::Concern

  included do
    validates :title, presence: true
    validates :body, presence: true
    validates :tag_list, presence: true
  end

  class_methods do 
  	def filter(params)
      if params[:title].present? || params[:body].present? || params[:tag].present?
        results = self.
          all.
          where('lower(title) like ?', "%#{params[:title].downcase}%").
          where('lower(body) like ?', "%#{params[:body].downcase}%")

        if params[:tag].present?
          tags = params[:tag].split(",").each(&:strip)
          results = results.tagged_with(tags, any: true)
        end
        results
      else
        self.all
      end
    end
  end
end