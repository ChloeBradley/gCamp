class CommonQuestion

  def initialize(question, answer, slug)
    @question = question
    @answer = answer
    @slug = slug

    def question
      @question
    end

    def answer
      @answer
    end

    def slug
      @slug
    end
  end
end
