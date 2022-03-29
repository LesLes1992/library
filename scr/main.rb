require "tty-prompt"
require "colorize"
require_relative "./books.rb"
# require_relative "./profiles.rb"




#welcome message and provide options to choose
#executed next accoding to user's input

def logo
    puts "---------------------------------------------------------------------"
    puts "                                                              
    ██╗     ██╗██████╗ ██████╗  █████╗ ██████╗ ██╗   ██╗      
    ██║     ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝      
    ██║     ██║██████╔╝██████╔╝███████║██████╔╝ ╚████╔╝       
    ██║     ██║██╔══██╗██╔══██╗██╔══██║██╔══██╗  ╚██╔╝        
    ███████╗██║██████╔╝██║  ██║██║  ██║██║  ██║   ██║         
    ╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝         ".colorize(:red )
    puts "---------------------------------------------------------------------"
end

def main_header
    prompt = TTY::Prompt.new
    options = ["Sign up", "Log in ", "Exit"]
    logo
    puts "Welcome to Coder's Library!"
    prompt.select("How can I help you?", options)
end
#create a sign-up profile and 
def create_profile(file)
    system "clear"
    hash = read_profile(file)
    username = get_username(hash)
    password = get_password 
    profile =  {username => password}
end


def read_profile(file)
    data = File.read(file)
    data.close
    return JSON.parse(data).sample
end

def get_username(hash)
    loop = "continue"
    print "Input your username  >> "
    while loop != "stop"
        username = gets.chomp!
        if username.empty?
            print "Username can't be empty,please input again >>"
        elsif hash.include? (username)
            print "The username has been taken, please try another one >>"
        else
            loop = "stop"
        end
    end
    return username
end

def get_password
    loop_2 = "continue"
    print "Password >> "
    while loop_2 != "stop"
        password =  gets.chomp!
        print "Re-enter your password >> "   
        password_sec = gets.chomp!
        if password != password_sec
            print "Invalida password input, please try again >>"
        else
            loop_2 ="stop"
        end
    end
    return password
end

def save_profile(user, file)
    File.write(file, JSON.dump(user))
end

def main 
    answer = main_header
    if answer == "Sign up"
        user = create_profile('profile.json')
        save_profile(user, 'profile.json') 
    end
end

if ARGV.size == 0
    main
end