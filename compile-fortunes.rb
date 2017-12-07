require 'sinatra'
def capitalize_with_I str
    str[0]=str[0].upcase()
    str.split(" ").each_with_index do |word, i|
        if word == "i"
            str[i]=word.upcase()
        end
    end
    return str
end

rng=Random.new
get '/' do
    file_array=[]
    names_array=[]
    open('fortunes.txt', "r") do |file|
        file.each_line do |line|
            if(line.index('―') == nil && line.index('—') == nil)
                line_to_add=line.strip()
                line_to_add.gsub!(/[%-:!?(),;"—#]/, "")
                file_array << line_to_add
            else
                name_to_add =line.strip()
                name_to_add.gsub!(/[-–]/, "")
                names_array << name_to_add
            end
        end
    end
    file_array.delete("")
    word_arrays=[]
    file_array.each do |line|
        word_arrays << line.split(" ")
    end
    name_split_arrays=[]
    names_array.each do |name|
        name_split_arrays << name.split(" ")
    end
    names_array=name_split_arrays.flatten()
    file_string=word_arrays.flatten()
    @wisdom=file_string.sample(rng.rand(5..20)).join(" ").downcase().capitalize
    @name=names_array.sample(2).join(" ")

    code="""
    <h1>Today's wisdom:</h1>
    <p style=\"text-decoration:underline\"><%= @wisdom%></p>
    <p><%=@name%></p>
    """
    erb code
end
