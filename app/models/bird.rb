class Bird < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    # def create
    #     bird = Bird.create(bird_params)
    #     if bird.valid?
    #       render json: bird, status: :created
    #     else
    #       render json: { errors: bird.errors }, status: :unprocessable_entity
    #     end
    # end

    # cleaner way of doing same thing
    # def create
    #     bird = Bird.create!(bird_params)
    #     render json: bird, status: :created
    #   rescue ActiveRecord::RecordInvalid => invalid
    #     render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    # end

      #using rescue_from
      def create
        # create! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
        bird = Bird.create!(bird_params)
        render json: bird, status: :created
      end

      def update
        bird = find_bird
        # update! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
        bird.update!(bird_params)
        render json: bird
      end


      private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
