class Api::RobotController < ApplicationController
    skip_before_action :verify_authenticity_token

    def test
        render json:{status: "testing"}
    end

    def create 
        moves = params[:commands]
        x = false
        y = false
        direction = false
        report = false
        place = false
        data = "#{x},#{y},#{direction}"
        if moves.present?
            moves.each do |move|
              if move[0..4]=="PLACE"
                place = move[0..4]
                x = move[6]
                x = x.to_i
                y = move[8]
                y = y.to_i
                direction = move[10..15]
              end
              if place =="PLACE" && ((x<5).present? && (x>-1).present? ) && ((y<5).present? && (y>-1).present? )
                if direction =="NORTH"
                    if move =="MOVE"
                       if x<4
                          x = x+1
                        end
                    elsif move == "LEFT"
                        direction = "WEST"
                    elsif move == "RIGHT"
                        direction = "EAST"
                    end
                elsif direction =="SOUTH"
                        if move =="MOVE"
                           if x>0
                              x = x-1
                            end
                        elsif move == "LEFT"
                            direction = "EAST"
                        elsif move == "RIGHT"
                            direction = "WEST"
                        end
                    elsif direction =="EAST"
                        if move =="MOVE"
                           if y<4
                              y = y+1
                            end
                        elsif move == "LEFT"
                            direction = "NORTH"
                        elsif move == "RIGHT"
                            direction = "SOUTH"
                        end    
                    elsif direction =="WEST"
                        if move =="MOVE"
                           if y>0
                              y = y-1
                            end
                        elsif move == "LEFT"
                            direction = "SOUTH"
                        elsif move == "RIGHT"
                            direction = "NORTH"
                        end    
                    end
                  data = "[#{x},#{y},#{direction}]"
              end
            end
        end

        if place =="PLACE" && ((x<5).present? && (x>-1).present? ) && ((y<5).present? && (y>-1).present? )
            render json: { location: data }
        else place =="PLACE" && x.present? && y.present? 
            render json: {location: "Wrong origin"}
        end
    end

end