# Smart Pension Test

This test is to test my skills in TDD and OOPS principles that I use when I build a ruby/ruby on rails application.
smart-pension-test is a simple application which results the number of visits and number of unique visits for each page that is provided in a log file.

# Output
The general output looks as follows
```
+--------------+--------+
| Page         | Visits |
+--------------+--------+
| /about/2     | 83     |
| /contact     | 81     |
| /home        | 72     |
| /help_page/1 | 71     |
| /index       | 71     |
| /about       | 66     |
+--------------+--------+
+--------------+---------------+
| Page         | Unique Visits |
+--------------+---------------+
| /help_page/1 | 20            |
| /contact     | 20            |
| /home        | 20            |
| /index       | 20            |
| /about/2     | 19            |
| /about       | 18            |
+--------------+---------------+
```

# Requirements
- Setup ruby greater that `2.6.0`. Follow this documentaion `https://www.ruby-lang.org/en/documentation/installation/` for more information.
- Install bundler using below command
  - `gem install bundler`
# Setup

* Make sure that ruby is installed in your local.
* Make sure all the gems needed are installed by running following command
    * `bundle install` 
* Run the following command in the cloned repository with the log file that needed to be parsed.
  * `ruby application.rb webserver.log`

# Running Tests
* Make sure all the gems needed are installed before running tests
    * `bundle install`
* Run all the specs with below command
    * `bundle exec rspec spec`

# Concepts
* Used `terminal-table` gem to display the results to the terminal/console in a better way.
* Used service patterns to maintain most of the code, as it looked more like services.
* Added `simplecov` gem to calculate the code coverage and currently the coverage is 100% :partying_face: .

# Improvement Suggestions
* We can think of storing the logs in DB store instead of parsing from the file.
* We can think of having a more efficient datastructure to store the results, currently I'm using nested hashes to serve the purpose and it looks like below
    ```
    {
        "/page1" => {
            "ip1" => 3,
            "ip2" => 5
        },
        "/page2" => {
            "ip2" => 4,
            "ip3" => 1
        }
    }
    ```
