1. Populate ticket_created_at in feedbacks

 Use VLOOKUP / XLOOKUP

=VLOOKUP(A2, ticket!A:E, 2, FALSE)

2. Outlet-wise ticket counts
a) Same day:
=COUNTIFS(created_at_range, date, closed_at_range, date, outlet_id_range, outlet_id)

b) Same hour:
=COUNTIFS(
  outlet_id_range, outlet_id,
  TEXT(created_at,"yyyy-mm-dd hh"), TEXT(closed_at,"yyyy-mm-dd hh")
)
