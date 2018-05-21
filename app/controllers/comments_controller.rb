class CommentsController < ApplicationController

    def create
        comment = Comment.new
        comment.content = params[:input_content]
        comment.note_id = params[:note_id]
        comment.save
        redirect_to "/notes/#{comment.note.id}"
    end
    
    def destroy
        comment = Comment.find params[:id]
        comment.destroy
        redirect_to "/notes/#{comment.note.id}"  
    end
end
