class MainController < ApplicationController
    autocomplete :patient, :firstname, :display_value => :customize_value

    def index
        @patient = Patient.new

        @chart = LazyHighCharts::HighChart.new('pie') do |f|
            f.chart({:defaultSeriesType=>"pie" , :margin=> [0, 0, 0, 0], :spacingBottom => 0} )
            series = {
                :type=> 'pie',
                :name=> 'Browser share',
                :data=> [
                    ['Firefox',   45.0],
                    ['IE',       26.8],
                    {
                :name=> 'Chrome',
                :y=> 12.8,
                :sliced=> true,
                :selected=> true
            },
                ['Safari',    8.5],
                ['Opera',     6.2],
                ['Others',   0.7]
            ]
            }
            f.series(series)
            f.legend(:layout=> 'horizontal',:style=> {:bottom=> '0px',:right=> '50px',:top=> '0px'})
            f.plot_options(:pie=>{
                :allowPointSelect=>true,
                :cursor=>"pointer" ,
                :dataLabels=>{
                :enabled=>true,
                :color=>"black",
                :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
            }
            }
            })
        end
    end

    def get_autocomplete_items(parameters)
        super(parameters)

        if params.has_key?(:scope)
            method = "search_by_" + params[:scope]

            Patient.send(method.to_sym, params[:term])
        end
    end

    def json_for_autocomplete(items, method, extra_data=[])
      items.collect do |item|
        hash = {"id" => item.id.to_s, "label" => self.format_autocomplete(item), "value" => item.send(method)}
        extra_data.each do |datum|
          hash[datum] = item.send(datum)
        end if extra_data
        # TODO: Come back to remove this if clause when test suite is better
        hash
      end
    end

    def format_autocomplete(item)
        render_to_string(:partial => "main/format_autocomplete.html.haml", :locals => {:item => item})
    end
end
