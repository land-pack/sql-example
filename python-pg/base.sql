
## Create a table

CREATE TABLE
test=# create table contacts(
id serial PRIMARY KEY,
name varchar (100),
phones TEXT []
);

# Insert one item

INSERT 0 1
test=# insert into contacts (name, phones)values(
'Frank AK',
ARRAY ['911','221']
);

# Query result 

test=# select * from contacts;
## id |   name   |  phones
##----+----------+-----------
##  1 | Frank AK | {911,221}
##(1 row)

# You can also use curly braces as follows:

insert into contacts (name, phones)values(
'William',
'{"345","789"}'
);

##test=# select * from contacts;
## id |   name   |  phones   
##----+----------+-----------
##  1 | Frank AK | {911,221}
##  2 | William  | {345,789}
##(2 rows)


# We access array elements using the subscript within square [].
# By default, PostgreSQL uses one-based numbering for array elements.
# It means the first array element starts with number 1. Suppose
# We want to get the contacts name and the first phone number, we use
# the following query:

select phones[2] from contacts;

# We can use array element in the WHERE clause as the condition to filter rows.

select name from contacts where phones[1]='911';

# Search by Any

 select name from contacts where '911'= ANY (phones);

# Expand Arrays

select name, unnest(phones) from contacts;
