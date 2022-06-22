class Menu
    attr_reader :created_train, :created_route, :created_stations
    
    def initialize
      @created_trains = []
      @created_route = []
      @created_stations = []
    end
     
  def start
    hello = "\nHello, these actions are available to you:\n
    1 ----- Creating a station
    2 ----- Creating a route
    3 ----- Adding a station
    4 ----- Creating a train
    5 ----- Deleting a station
    6 ----- Adding a wagon
    7 ----- Deleting a wagon
    8 ----- Move the train
    9 ----- View the list of stations and the list of trains at the station
    10 ----- Exit"

    puts hello
  end
  
  def choise
    status = true
  
    while status
      puts "Enter the action number:"
      selection = gets.to_i
  
      case selection
      when 1 then create_station
      when 2 then create_route
      when 3 then add_station
      when 4 then create_train
      when 5 then remove_station_menu
      when 6 then add_wagon_menu
      when 7 then remove_wagon
      when 8 then move
      when 9 then show_current_objects
      when 10 
        puts "Bye"
        status = false
      end
    end
  end
  
  private

  def create_station
    puts "Enter the station name:"
    st_name = gets.chomp
      
    @created_stations.push(Station.new(st_name))
  
    puts "All stations: #{@created_stations}"
  end

  def create_route
    puts "You have these stations:"
  
    if @created_stations.size >= 2
      @created_stations.each_with_index do |st, i| 
        puts "#{i + 1} -- #{st.st_name}" 
      end

      puts "Choose a start station"
      start_station = gets.chomp.to_i
  
      puts "Choose a end station"
      end_station = gets.chomp.to_i
    
      @created_route << Route.new(@created_stations[start_station], @created_stations[end_station])
      puts "Your route: #{@created_route}\nNow you can add other stations to the route"
    else
      puts "Add another station"
    end
  end

  def add_station
    return "Added start and end stations" if @created_route.empty?

      @mid_stations = @created_stations[1..-2]
      puts "You can add this stations"
      @mid_stations.each_with_index do |st, i|
        puts "#{i + 1} -- #{st}"
      end

      puts "Choose an intermediate station"
      choise_mid_st = gets.chomp.to_i
    
      puts "Choose route for add station"
      @created_route.each_with_index do |st, i|
        puts "#{i + 1} -- #{st}"
      end
      choosed_route = gets.chomp.to_i

      @created_route[choosed_route - 1].add_middle_st(@mid_stations[choise_mid_st])
      puts @created_route
  end

  def create_train
    return if @created_route.size == 0
      puts "You need add route"
      puts "Enter the type train:\n1 - Passenger, 2 - Cargo)"
      type_train = gets.chomp.to_i
      
      puts "Choose route for create train"
      @created_route.each_with_index do |st, i|
        puts "#{i + 1} -- #{st}"
      end
      choosed_route_tr = gets.chomp.to_i

      puts 
      case type_train
      when 1 then @created_trains << PassengerTrain.new(@created_route[choosed_route_tr])
      when 2 then @created_trains << CargoTrain.new(@created_route[choosed_route_tr])
      puts "Train has been created"
      else
      puts "err"
      end
  end

  def remove_station_menu
    return "You need add station" if @created_route.size == 0
    
    puts "Choose station for removing"
    @created_stations.each_with_index do |st, i|
      puts "#{i + 1} -- #{st}"
    end
    choosed_remove_st = gets.chomp.to_i

    puts "Choose route for remove station"
      @created_route.each_with_index do |st, i|
        puts "#{i + 1} -- #{st}"
      end
    choosed_route_rem = gets.chomp.to_i

    @created_route[choosed_route_rem - 1].remove_station(@created_stations[choosed_remove_st - 1])
    puts "Station has been removed"
  end

  def add_wagon_menu
    puts "Select a train to add a wagon"
    @created_trains.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_add_wagon = gets.chomp.to_i

    #type_train_and_wagon = @created_trains[choosed_add_wagon - 1].type 

    if @created_trains[choosed_add_wagon - 1].type == "passengers"
      wagon = PassengerWagon.new
      @created_trains[choosed_add_wagon - 1].add_wagon(wagon)
    elsif @created_trains[choosed_add_wagon - 1].type == "cargo"
      wagon = CargoWagon.new
      @created_trains[choosed_add_wagon - 1].add_wagon(wagon)
    else
      puts "err"
    end
  end
 
  def remove_wagon
    puts "Select the train to which you want to remove a wagon"
    @created_trains.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_remove_wag = gets.chomp.to_i
    
    puts "Select wagon to remove"

    @created_trains[choosed_remove_wag - 1].delete_wagon
    puts "Wagon has been removed"
  end

  def move
    puts "1 -- next station\n2 -- go back"
    choosed_move = gets.chomp.to_i

    puts "Choose a train to move"
    @created_trains.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_move_tr = gets.chomp.to_i

    case choosed_move
    when 1 then @created_trains[choosed_move_tr - 1].up_action
    when 2 then @created_trains[choosed_move_tr - 1].down_action
    end
  end

  def show_current_objects
    @created_trains.each do |tr| 
      puts "Train:\n#{tr}"
    end

    @created_stations.each do |st|
      puts "Station: #{st.st_name}" 
    end
  end
end
