class Menu
    attr_reader :created_train, :created_route
    
    def initialize
      @created_route = []
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
    10 ----- Show all wagons in train
    11 ----- Add train in station
    12 ----- Show all trains in station
    13 ----- Take a seat in a passenger car
    14 ----- Take a volume in a cargo car
    15 ----- Exit"

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
      when 10 then Train.each_wagons { |wag| puts wag }
      when 11 then add_train_in_st
      when 12 then Station.each_trains { |st| puts st }
      when 13 then take_wag_seat
      when 14 then take_wag_vol
      when 15
        puts "Bye"
        status = false
      end
    end
  end
  
  private

  def take_wag_seat
    puts "Choose a wagon"
    PassengerWagon.all.each_with_index do |wag, i|
      puts "#{i + 1} -- #{wag}"
    end
    choosed_pass_wag = gets.chomp.to_i

    PassengerWagon.all[choosed_pass_wag - 1].take_seat
  end

  def take_wag_vol
    puts "Choose a wagon"
    CargoWagon.all.each_with_index do |wag, i|
      puts "#{i + 1} -- #{wag}"
    end
    choosed_cargo_wag = gets.chomp.to_i

    puts "How much volume do you want to take?"
    choosed_volume = gets.chomp.to_i

    CargoWagon.all[choosed_cargo_wag - 1].take_wag_volume(choosed_volume)
  end 

  def add_train_in_st
    puts "Choose a station"
    Station.all.each_with_index do |st, i|
      puts "#{i + 1} -- #{st}"
    end
    choosed_station = gets.chomp.to_i

    puts "Choose a train"
    Train.all.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_train = gets.chomp.to_i

    Station.all[choosed_station - 1].add_train(Train.all[choosed_train - 1])
    puts "Train has been added"
  end

  def create_station
    puts "Enter the station name:"
    st_name = gets.chomp
      
    Station.new(st_name)
  
    puts "All stations: #{Station.all}"
  end

  def create_route
    puts "You have these stations:"
  
    if Station.all.size >= 2
      Station.all.each_with_index do |st, i| 
        puts "#{i + 1} -- #{st.st_name}" 
      end

      puts "Choose a start station"
      start_station = gets.chomp.to_i
  
      puts "Choose a end station"
      end_station = gets.chomp.to_i
    
      @created_route << Route.new(Station.all[start_station], Station.all[end_station])
      puts "Your route: #{@created_route}\nNow you can add other stations to the route"
    else
      puts "Add another station"
    end
  end

  def add_station
    return "Added start and end stations" if @created_route.empty?

      @mid_stations = Station.all[1..-2]
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
    begin
      return "You need add route" if @created_route.size == 0
        puts "Enter the type train:\n1 - Passenger, 2 - Cargo)"
        type_train = gets.chomp.to_i
        
        puts "Choose route for create train"
        @created_route.each_with_index do |st, i|
          puts "#{i + 1} -- #{st}"
        end
        choosed_route_tr = gets.chomp.to_i

        puts "Enter the number train"
        num_train = gets.chomp
  
        case type_train
        when 1
          @train = PassengerTrain.new(num_train, @created_route[choosed_route_tr])
          puts "Passenger train has been created" if @train.valid?
        when 2
          @train = CargoTrain.new(num_train, @created_route[choosed_route_tr])
          puts "Cargo train has been created" if @train.valid?
        end

      rescue RuntimeError => e
        puts e 
        retry
    end
  end

  def remove_station_menu
    return "You need add station" if @created_route.size == 0
    
    puts "Choose station for removing"
    Station.all.each_with_index do |st, i|
      puts "#{i + 1} -- #{st}"
    end
    choosed_remove_st = gets.chomp.to_i

    puts "Choose route for remove station"
      @created_route.each_with_index do |st, i|
        puts "#{i + 1} -- #{st}"
      end
    choosed_route_rem = gets.chomp.to_i

    @created_route[choosed_route_rem - 1].remove_station(Station.all[choosed_remove_st - 1])
    puts "Station has been removed"
  end

  def add_wagon_menu
    puts "Select a train to add a wagon"
    Train.all.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_add_wagon = gets.chomp.to_i

    if Train.all[choosed_add_wagon - 1].type == "passengers"
      puts "How many seats will the car have?"
      num_seats = gets.chomp.to_i

      wagon = PassengerWagon.new(num_seats)
      Train.all[choosed_add_wagon - 1].add_wagon(wagon)
    elsif Train.all[choosed_add_wagon - 1].type == "cargo"
      puts "What volume will the wagon have?"
      volume = gets.chomp.to_i

      wagon = CargoWagon.new(volume)
      Train.all[choosed_add_wagon - 1].add_wagon(wagon)
    else
      puts "err"
    end
  end
 
  def remove_wagon
    puts "Select the train to which you want to remove a wagon"
    Train.all.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_remove_wag = gets.chomp.to_i
    
    puts "Select wagon to remove"

    Train.all[choosed_remove_wag - 1].delete_wagon
    puts "Wagon has been removed"
  end

  def move
    puts "1 -- next station\n2 -- go back"
    choosed_move = gets.chomp.to_i

    puts "Choose a train to move"
    Train.all.each_with_index do |tr, i|
      puts "#{i + 1} -- #{tr}"
    end
    choosed_move_tr = gets.chomp.to_i

    case choosed_move
    when 1 then Train.all[choosed_move_tr - 1].up_action
    when 2 then Train.all[choosed_move_tr - 1].down_action
    end
  end

  def show_current_objects
    puts Train.all

    puts Station.all

    puts @created_route
  end
end
