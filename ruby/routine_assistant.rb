require "date"

class RoutineAssistant
  TIME_OF_SLEEPING = 7.5

  def initialize
    @todays_date = Date.today
  end

  def usage
    puts <<-EOS
    USAGE: You need to enter an argument.
    
    OPTIONS:
    -time             Show how many days and times are left this year.
    -relax            Show the process for taking a deep breath is displayed.
    -motivation       Show the list of things to do when you lose your concentration.
    -sleep            Show the list of things to do before going to bed.
    -book             You can display what percentage you read according to the total number of pages.
                      For example, if you read 50 pages of a 300-page book, 
                      you enter 「ruby today\'s_to_do.rb -book 50 300」.
    EOS
    exit
  end

  def calculate_days_from_until_the_end_of_year
    Date.parse("#{@todays_date.year}1231") - @todays_date
  end

  def calculate_times_to_the_end_of_year
    calculate_days_from_until_the_end_of_year * 24
  end

  def calculate_times_to_deadline_excluding_sleep_time
    calculate_times_to_the_end_of_year - (calculate_days_from_until_the_end_of_year * TIME_OF_SLEEPING)
  end

  def calculate_book_page_number(read_pages, total_pages_of_book)
    (read_pages / total_pages_of_book.to_f * 100).round(1)
  end

  def output_of_remaining_time_and_days
    puts <<-"EOS"
    本日は#{@todays_date}で、年末まで残り#{calculate_days_from_until_the_end_of_year}日です。
    時間換算すると#{calculate_times_to_the_end_of_year}時間です。
    睡眠時間を除くと#{calculate_times_to_deadline_excluding_sleep_time}時間です。
    年末に後悔しないように、時間を意識して生活しましょう。
    EOS
  end

  def show_deep_breath_process
    puts "5秒吸って6秒かけて吐く、これを10回繰り返しましょう。120秒後に「深呼吸完了です。」と表示されます。"
    sleep(120)
    puts "深呼吸完了です。"
  end

  def show_list_when_lose_concentration
    puts <<-EOS
    集中が切れたときにやると有効的なリストは
    ・冷水で顔を洗う
    ・立ち上がって軽くストレッチをする
    ・深呼吸をする
    ・30分以下の仮眠を取る
    です。
    集中が切れた際には、ぜひ試してみましょう。
    EOS
  end

  def show_list_before_going_to_bad
    puts <<-EOS
    寝る前にやると有効的なリストは
    ・今日学んだことを10分で振り返る
    ・明日やることをまとめる
    ・約30分読書する
    です。
    思考が整理されリラックスできるため、深い眠りにつくことができます。
    EOS
  end

  def show_pace_read_book(read_pages, total_pages_of_book)
    puts "本日は#{read_pages}ページ進捗しました。これは全体の#{calculate_book_page_number(read_pages, total_pages_of_book)}％に値します。"
  end

  def run(user_choice, read_pages, total_pages_of_book)
    case user_choice
    when "-time"
      output_of_remaining_time_and_days
    when "-relax"
      show_deep_breath_process
    when "-motivation"
      show_list_when_lose_concentration
    when "-sleep"
      show_list_before_going_to_bad
    when "-book"
      calculate_book_page_number(read_pages, total_pages_of_book)
      show_pace_read_book(read_pages, total_pages_of_book)
    else
      usage
    end
  end
end

if __FILE__ == $0
  routine_assistant = RoutineAssistant.new
  if ARGV.size == 0
    routine_assistant.usage
  end
  routine_assistant.run(ARGV[0].to_s, ARGV[1].to_i, ARGV[2].to_i)
end