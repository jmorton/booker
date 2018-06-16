# Data Model

The system exposes data about Guests, Owners, Units, and Reservations.

## Guest

Someone that wants to occupy a unit for a specific period of time.

## Owner

Someone that has a place for guests to reserver.

## Identity

Data about an authentication mechanism used by a person visiting the site. This separates authentication related data from everything else.

## Unit

A place that can be occupied for various intervals of time by different guests.

Units are geocoded whenever their address is changed in order to support location based queries.

## Reservation

A date-interval exclusive relationship between guests and units. A valid guest, unit, and duration are required.

## Audits

The system keeps old versions of entities to assist system operators with insight about what people are doing and to help resolve potential disputes.

## Search

A model that contains a place, start date, and end date used to find available units. This model is not persisted.

