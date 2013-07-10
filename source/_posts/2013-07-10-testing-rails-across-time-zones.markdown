---
layout: post
title: "Testing Rails across time zones"
date: 2013-07-10 11:14
comments: true
categories:
- ruby
- rails
- development
---


Why?
--------------

Because it is easy to get the dates/times wrong without realising it.


How?
---------------

1. Randomise time zone when rinning specs
2. Run the specific specs across the different time zones


Usage: Randomise time zone when rinning specs
----------------

The RSpec support file will (part of this Gist) sets the Rails' `Time.zone` to a random time zone.
So if something is wrong then your CI should eventually fail.

When it will, you should look for the message at the very beginning:

```
Current rand time zone: (GMT+06:30) Rangoon. Repro: Time.zone = ActiveSupport::TimeZone["Rangoon"]
```

Then go to your failing spec and in the context of it add the following
(assuming you copy pasted the "Repro" part from the message):

```ruby
  before { Time.zone = ActiveSupport::TimeZone["Rangoon"] }
```

Now you can re-run the spec and it should repetably and predictably fail (much like RSpec's random order with a given seed).

This works without changing any of the existing specs and relies on
the fact that your CI is running specs often enough.


Run the specific specs across the different time zones
----------------

You may have some specs that you want to specifically test across all the time zones.

This can be used, for example, with tests on reports that are sensitive to time zone.
(All fincancial/sales reports probably).


So how do you do it?

Just write the normal specs without thinking about the time zone.
Let's take this as an example:

```ruby
require 'spec_helper'

module SalesReport
  describe SalesChart  do

    it "should return chart with data for a week as daily summary" do
      create_three_reservations_per_day 0..1
      chart = SalesChart.for_company(reservations, company)
      chart.data_table.cols.size.should == 4
      rows_from(chart).should == [
        [1.day.ago.to_date, 3, 2, 1],
        [Date.current, 3, 2, 1]
      ]
    end

    # helpers ommited...
  end
end
```

Make sure it passes in your timezone.

Then just wrap your spec in `across_time_zones`, like so:

```ruby
require 'spec_helper'

module SalesReport
  describe SalesChart  do

    across_time_zones step: 2.hours do
      it "should return chart with data for a week as daily summary" do
        create_three_reservations_per_day 0..1
        chart = SalesChart.for_company(reservations, company)
        chart.data_table.cols.size.should == 4
        rows_from(chart).should == [
          [1.day.ago.to_date, 3, 2, 1],
          [Date.current, 3, 2, 1]
        ]
      end
    end

    # helpers ommited...
  end
end
```

You'll be surprised how many things can go wrong. Especially if you have some more advanced DB queries
that use (in PostgreSQL terms) dates, times and times with time zone, maybe `DATE_TRUNC` etc.

Now that spec will be created for each time zone with the given step.


Tips/Gotchas
--------------

- The default `step` here is set to 8 hours (it is optional), meaning that only 3 time zones will be tested. It may be sufficient or may not. So prefer to provide it expclicitly.
- The smaller the `step` is, the more specs will be created and the slower the example will become. So choose the number wisely (less than 2 hours is *usually* not necessary).
- Always, always use `Time.zone.now` (or `Time.current`) instead of `Time.now`.
- Always, always use `Date.current` instead of `Date.today`.
- Move any `let!` (with bang) and `before` blocks under the `across_time_zones` to ensure the correct time zone is used at all times.


Grab the RSpec support file from
{% gist 5962765 %}
