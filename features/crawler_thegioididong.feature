Feature: Crawler all data the gioi di dong

    Scenario: Try to create new location
        Given Go to thegioididong homepage
        When Click loadmore in homepage
        Then Crawl all data in homepage