# SLM

SLM is a Spotify List Manager. With a source file and a changes file it will apply the changes to the source file and create an ouput file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slm'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install slm

## Usage

SLM needs a source file and a changes file in JSON format. These files are located in a directory called ```json```. A base directory for the files can be indicated with a ```--base``` option or ```-b``` flag. To process the changes to the source file and create an ouput file, run the following:

```
    $ slm process --base "json" spotify.json changes.json output.json
```

After running the command you should now see a file named ```output.json``` in the ```json``` directory. Opening the file should reveal a copy of the ```spotify.json``` file with the changes implemented.

## Scale

To handle very large input or change files I might introduce queueing and use something like Redis and Sidekiq for processing. If it being a CLI was not a requirement then I would be inclined to create it as a Rails project with a database and a simple GUI.

## Design

I chose to use the Thor gem as I have found it to be a great tool for creating CLIs as well as the consideration that future assignments would build upon the project.

## Time

I looked over the assignment on Friday but wasn't able to sit down and start work on it until Monday. I did, however, spend time here and there over the weekend thinking about the approach I might take. Once I began, I spent somewhere around an hour or so to get an initial working product and then another half hour or so tweaking and optimizing some things (with a few interruptions from a daughter who just got braces letting me know how much her mouth hurt 😁).