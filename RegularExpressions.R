############# REGULAR EXPRESSIONS ############# 

## REGULAR EXPRESSIONS
# - Regular expressions can be thought of as a combination of literals and metacharacters.
# - To draw an analogy with natural language, think of literal text forming the
# words of this language and metacharacters defining its grammar.
# - Regular expressions have a rich set of metacharacters.

## LITERALS
# Simplest pattern consists only of literals (exactly match of what you observe).

## REGULAR EXPRESSIONS
# - Simplest pattern consists only of literals; a mathc occurs if the sequence of
# literals occurs anywhere in the text being tested.
# - What if we only want the word "Obama"? Or sequences that end in the "Clinton", 
# or "clinton", or "clinto"?

# We need a way to express:
# - Whitespace word boundaries
# - Sets of literals
# - The beginning and end of a linte
# - Alternatives ("war" or "peace") -> Metacharacters to the rescue!

## METACHARACTERS

## Metacharacter ^ represents the start of a line:
# ^i think
# will match the lines:
# i think we all rule for participating
# i think i have been outed
# i think this will be quite fun actually
# i think i need to go to work
# i think i first saw zombo in 1999.

## Metacharacter $ represents the end of a line:
# morning$
# will match the lines:
# well tey had something this morning
# then had to catch a tram home in the morning
# dog obedience school in the morning
# and yes happy birthday i forgot to say it earlier this morning
# I walked in the rain this morning
# good morning

## Character Classes with[]
# we can list a set of characters we will accept at a given point in the match.
# [Bb][Uu][Ss][Hh] : either a lower case or capital B, either a lower case or capital U, ...
# (It will match all the version of the word Bush)
# will match the lines:
# The democrats are playing, "Name the worst thing about Bush!"
# I smelled the desert creosote bush, brownies, BBQ chicken
# BBQ and bushwalking at Mongolo Gorde
# Bush TOLD you that North Korea is part of the Axis of Evil
# I'm listening to Bush - Hurricane (Album Version)

## Combining the metacharacters together
# ^[Ia] am
# will match:
# i am so angry at my boyfriend
# i am boycotting the aplle store
# I am twittering from iPhone
# I am a very vengeful person when you ruin my sweetheart.

## Similarly we can specify a range of letters [a-z] or [a-zA-Z].
# Note that the order does not matter.
# ^[0-9][a-zA-Z] (looking for a number before a letter in the beginning of the line)
# will match these lines:
# 7th inning stretch
# 2nd half soon to begin. OSU did just win something
# 3am - cant sleep
# 5ft 7 sent from heaven
# 1st sign of starvagtion

## When used at the beginning of a character class, the ^ is also a metacharacter.
# In this case, ^ indicates matching characters NOT in the indicated class.
# [?.]$
# (Any line that does not end with a period or a question mark)
# will match the lines
# i like basketballs
# 6 and 9
# dont worry... we all die anyway!
# helicopter inder water? hmmm

## "." IS USED TO REFER TO ANY CHARACTER
# 9.11 
# -> any place where theres a 9 followed by 11, between any character.

## | OR METACHARACTER
# flood|fire 
# -> any place where there is the word flood or the word fire.
# The subexprssions foold and fire are callded alterantives.

# Any number of alterantives we need.
# flood|earthquake|hurricane|coldfire

# The alternatives can be real expressions, not just literals.
# ^[Gg]ood | [Bd]ad
# -> the line has to star with Good or good OR it must have the word Bad or bad anywhere.

# Subexpressions are often contained in parenthesis to constrain the alternatives.
# ^([Gg]ood | [Bd]ad)
# -> it will search for Good or good OR Bad or bad in the beginning of the lines.

## ? OPTIONAL METACHARACTER
# The question mark indicates that the indicate expression is optional.
# [Gg]eorge( [Ww]\.)? [Bb]ush 
# We are looking for George Bush, with potentially the W. in the middle

## ONE THING TO NOTE
# [Gg]eorge( [Ww]\.)? [Bb]ush 
# we wanted to match a "." as a literal period; to o that, we had to "escape" the
# metacharacter, preceding it with a backslash. In general, we have to do this for
# any metacharacter we want to include in our match.

# METACHARACTERS: * AND +
# They are used to indicate repetition.
# * means "any number of times, including none, of the item"
# + meand "at least one of the item"
# (.*) -> something between a parenthesis and it can be any character repeated any
# number of times.

# [0-9]+ (.*) [0-9]+
# At least one number, followed by any number of characters followed by at
# least one number again.
# Any possible combination of numbers that are separated by something other than numbers.

## MORE METACHARACTERS: {}
# {} are referred to as interval quantifiers; it lets us specify the minimum and the
# maximum number of matches of an expression.
# [Bb]ush( +[^ ]+ +){1,5} debate
# Bush, either capital or lower case and at the end debate. And between at least one
# space, followed by something that's not a space, followed by at least one space, and
# we want to see that between one and five times.
# Summarizing:
# There must be one, two, three, four or five words betwenn Bush and debate, with the
# proper spaces.
# Bush has historically won all major debates he's done.

# Inside the {}
# - {m,n} means at least m,but not more than n matches
# - {m} means exactly m matches
# - {m,} means at least m matches

## MORE METACHARACTERS: () REVISITED
# - In most implementations of regular expressions, the parentheses not only limit
# the scope of alternatives fivided by a "|", bu also can be used to "remember" 
# text matched by the subexpression encloded
# - We refer to the matched text with \1, \2, etc.

# +([a-zA-A]+) +\1 +
# Looking for a space, followed by at least one character, followed by 
# at least one space, followed by the exact same match that we saw within 
# the parenthesis, followed by at least one space.
# Note that it is something equivalent to:
# +([a-zA-A]+) +([a-zA-A]+) +([a-zA-A]+) +([a-zA-A]+) +([a-zA-A]+) +([a-zA-A]+) indefinitely
# It is looking for repetition:
# time for bed, night night twitter!
# blah blah blah blah

# The * is "greedy" so it always matches the longest possible string that satisfies the regular expression.
# ^s(.*)s
# In this case we are starting in the beginning of a string and we are looking for a s followed by
# some possibly large number of characters, followed by another s.
# Examples:
# sitting at starbucks
# setting up mysql and rails
# spaghetti with marshmallows

# The greddiness of + can be turned off with the ?, as in
# ^s(.*?)s$
# Now we start with s and ffollow up with some smaller number of characters, it is not going to
# find the maximum like throught the string, followed by something with an S at the end of
# the string.

## SUMMARY
# - Regular expressions are used in many diffrent languages, not unique to R.
# - Regular expressions are composed of literals and metacharacters that represent sets or 
# classes of characters/words.
# - Text processing via regular expression is a very powerful way to extract data from 
# "unfriendly" sources (not all data comes as a CSV file)
# - Used with functions grep, greol, sub, gsbu and others that involv searching for text strings.




