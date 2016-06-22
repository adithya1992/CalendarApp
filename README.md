# CalendarApp

##PART 1

A REST API in Ruby on Rails that accepts a set of events for a single day and returns how these events can most efficiently be laid out on a calendar. 

For example:

{id : 1, start: 60, end : 120}, // an event from 10am to 11am
{id : 2, start: 100, end : 240}, // an event from 10:40am to 1pm
{id : 3, start: 700, end : 720} // an event from 8:40pm to 9pm

The REST API will respond with an array of event objects that have a left, top and width property set relative to the overall size of the Canvas on which the events will be laid out, in addition to the id, start, and end

­Every colliding event will be the same width as every other event that it collides width.

­An event will use the maximum width possible while still adhering to the first constraint. If there is only one event at a given time slot, its width will be 100%.


##PART 2

Creating a web page by making use of the REST API from Part I, laying out the provided events as specified by the REST API response. 
