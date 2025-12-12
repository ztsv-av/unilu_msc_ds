# Cloud Computing

Cloud computing - distributed computations(scaling up (buying more artists, memory)), preconfigured services (computations, visualizations), elasticity (adapting computational needs), redundancy, recovery, maintainance.

Traditionally, Database Management Systems (DBMS's) are very good at running analytical queries (OLAP) and transactions (OLTP).
- All data are stored in tables, and queries are formulated in SQL.
- Typical DBMS deployments manage GBs-TBs of data.

The data model is based on the Relational Data Model, query semantics is based on Relational Algebra (select, project, join, etc.)

But what if we really have massive amounts of data?
- Google, Yahoo, Amazon, Ebay, Facebook, Twitter, Microsoft manage >>1 PB of data.
- Relational DBMS's used only for very specific purposes.

Vast majority of data is kept in much simpler but distributed data stores.
- Distributed file systems
- KeyValue stores
- NoSQL databases
- MapReduce paradigm

A Database Management System (DBMS) comprises a self-describing collection of integrated records.
- Self-describing: fixed DB schema, dictionaries, metadata.
- Integrated: data files, indexes, application metadata are all managed by the DBMS automatically.

Integrated data: only 1 database instance is accessed by all users; DB schema explains how to interpret the data.

Reduced data duplication: normalized DB schema avoids data inconsistencies and redundant storage of information.

Program/data independence: changes in the format or physical storage of the data have no consequences on the application programs.

Unified representation of user perspectives: user management is a core component of the DBMS (Queries & Updates <=> Transactions <=> Consistency)

## Scaling-Up vs Scaling-Out

<div style="text-align: center;">
  <img src="ims/image.png" alt="Image Description" />
</div>

# Big Data

The 4 Big V's of "Big Data” (and Cloud Computing…)
- Volume
  - Lots of data
- Velocity
  - Changing / growing data
- Variety
  - Heterogeneity of data (different formats: JSON, cvs,...)
- Verity
  - Correct / true or not?

# MapReduce

MapReduce is a framework using which we can write applications to process huge amounts of data, in parallel, on large clusters of commodity hardware in a reliable manner.

MapReduce is a processing technique and a program model for distributed computing based on java. The MapReduce algorithm contains two important tasks, namely Map and Reduce. Map takes a set of data and converts it into another set of data, where individual elements are broken down into tuples (key/value pairs). Secondly, reduce task, which takes the output from a map as an input and combines those data tuples into a smaller set of tuples. As the sequence of the name MapReduce implies, the reduce task is always performed after the map job.

<div style="text-align: center;">
  <img src="image-1.png" alt="Image Description" />
</div>

"Reduce-Side" join in terms of MapReduce. The joinkey can be any (set of) attribute value(s) from tuples in R1,…,Rn for which equality is checked
```
Function Map(Relations R1,…,Rn):
  FOR each tuple t IN R1,…,Rn DO
    EMIT(t.joinkey, <t, Ri
    >);

Function Reduce(joinkey, <t1, R1>,<t2,R2>,…,<tm,Rm>):
  RETURN <t1, t2, …, tm>;
```
```

d_1 = "a b c a b b c"
d_2 = "a b d d"
map_1(d_1, "a b c a b b c") -> [(a,1), (b,1),...]
map_2(d_2, "a b d d") -> [(a,1), (b,1),...]
reduce_1(a,[1,1,1]) -> [(a,3)]
reduce_2(b,...) -> ...
reduce_3(c,...) -> ...
reduce_4(d,...) -> ...
```
Map and Reduce and be any functions! For example countring sum of squares of even and odd numbers. Use many map (depending on how many numbers you have) and then 2 reducers: 1 reducer for odd and 1 for even sums.

# Relational Database Management Systems

## Data Modeling Principles (ODL & ERM & RDM)

### What is a Data Model?

1. Formal representation of data
   Examples:
   - ODL(object definition language): Interfaces/Classes, Attributes, Relationships
   - ERM (entity relational model): Entity Sets, Attributes, Relationships
   - RDM (relational data model): Tables, Rows, Columns, (Foreign) Keys
   - XML: Trees/Graphs of Elements, Attributes, Links
   - JSON: Key-Value Pairs (Maps & Arrays, possibly nested)

2. Operations
   - Transform one instance of the data model into another instance of the same data model.

3. Constraints
   - Specify which instances of the data model are allowed.

### Example

Suppose we aim to design a movie database with information about movies, stars, studios, directors, and their relationships with each other.

- A Movie entity has attributes: title, year, length, inColor, filmType.

- Star and Studio entities have attributes: name and address.

- A MovieExecutive (i.e., a president of a studio or a producer of a movie) has attributes: name, address, and netWorth.

Keys:
- The name attributes of a Star, Studio, and MovieExecutive entity uniquely identify the respective entity.

- However, a Movie entity can only be uniquely identified by the combination of its title and year attributes.

Foreign Keys:
- The Movie, Star, Studio, and MovieExecutive entities stand in different relationships with each other. For example, a Star acts ("starsIn") in different movies. A studio produces ("owns") multiple movies but has exactly one president ("hasPresident"), etc.

### Object Definition Language (ODL)

Main concepts:

- Objects represent instances of classes, each with a unique id/reference.

- Classes are collections of objects with similar properties.
  - "Store all actors of a movie into one class and all producers of a movie into another class."

- Every object instance must belong to exactly one class.

There are three kinds of class properties in ODL:

- Attributes;
- Relationships;
- Methods (not explicitly considered here).

#### Class Declarations

General form of declaring a class in ODL:
```
class <name> { <list of properties> } ;
```
Attributes describe properties of classes whose values have a simple type.
(integer, float, character, string, boolean, Enum - finite enumeration)
```
class Movie {
  attribute string title;
  attribute integer year;
  attribute integer length;
  attribute Enum Film 
    { color, blackAndWhite } filmType;
} ;
```
filmType is the name of the fourth attribute. Its type is called Film, and it is an enumeration type that contains two values: color and blackAndWhite.
```
class Star {
    attribute string name;
    attribute Struct Addr { string street, string city } address;
} ;
```
The second attribute has a record type Addr, with a street and a city component. Attributes defined within a Struct may only be atomic types (but no other nested structs, classes, etc.).

#### Classes vs Interfaces

An object must be an instance of exactly one class.

A class can be a subclass of at most one other superclass ("isA" hierarchy).
```
class MurderMystery extends Movie {
    attribute string suspect;
};
```

Similarly to a class, an interface may be used to declare the properties of an object. (here Movie must be another interface, not the name of a class)
``````
interface MurderMystery : Movie {
    attribute string suspect;
};
``````
However, classes (or interfaces) may implement multiple interfaces. This concept is called multiple inheritance.
``````
interface SciFiMurderMystery : MurderMystery, SciFi {
    ...
};
``````

Inheritance: 'extends'\
Multiple Inheritance: ':'

##### Diamond of Death

It is a directed asyclic graph (what you get with multiple inheritance, but can get conflicts with same attributes but different data types).

<div style="text-align: center;">
  <img src="image-4.png" alt="Image Description" width="300" height="300"/>
</div>

#### Relationships

```
interface Movie {
    attribute string title;
    attribute Enum Film { color, blackAndWhite } filmType;
    relationship Set<Star> stars;
};
```
There is a relationship between movies and stars. The name of the relationship is stars. It indicates that with each Movie, a set called stars is associated. The set can contain 0 or more elements. It is thus called a multi-valued relationship. Such a relationship cannot be represented by an attribute. An attribute cannot be represented by a relationship.
```
interface Movie {
    attribute string title;
    attribute Enum Film { color, blackAndWhite } filmType;
    relationship Star starOf;
};
```
There is a relationship between movies and stars. The name of the relationship is starOf. It indicates that with each Movie object, at most one (i.e., 0 or 1) star is associated. It is thus called a single-valued relationship.

Set - multiple stars
"relationship Star starOf;" - no Set method - single star

##### Inverse Relationships

```
interface Star {
    attribute string name;
    attribute Struct Addr 
      { string street, string city } address;
    relationship Set <Movie> starredIn 
      inverse Movie::stars;
};

interface Movie {
    attribute string title;
    attribute integer year;
    attribute integer length;
    attribute Enum Film 
      { color, blackAndWhite } filmType;
    relationship Set <Star> stars 
      inverse Star::starredIn;
};
```
The starredIn relationship of Star is the inverse of the stars relationship of Movie, and vice versa: if the movie m is in the starredIn set of the star s, then the star s must be in the stars set of the movie m, and vice versa. The indication 'inverse' must be given in both interfaces!


##### Different Multiplicities of Relationships

```
interface Star {
  attribute string name;
  attribute Struct Addr
    {string street, string city} address;
  relationship Set <Movie> starredIn
    inverse Movie::stars;
} ;

interface Movie {
  attribute string title;
  attribute integer year;
  attribute integer length;
  attribute Enum Film {color, b&w} filmType;
  relationship Set <Star> stars
    inverse Star::starredIn;
  relationship Studio ownedBy
    inverse Studio::owns;
} ;

interface Studio {
  attribute string name;
  attribute string address;
  relationship Set <Movie> owns
    inverse Movie::ownedBy;
  relationship MovieExec hasPres
    inverse MovieExec::isPresOf;
} ;

interface MovieExec {
  attribute string name;
  relationship Studio isPresOf
    inverse Studio::hasPres;
} ;
```

- starredIn and stars are both many-many (N:M) relationships;
- ownedBy is a many-one (N:1) relationship;
- owns is a one-many (1:N) relationship;
- isPresOf and hasPres are both one-one (1:1) relationships.

**Recursive relationship:**
```
interface Person {
  attribute integer identification;
  relationship Set <Person> hasSiblings
    inverse hasSiblings;
} ;
```

- hasSiblings is a many-many (N:M) relationship.

This particular (recursive) definition of a relationship and its inverse
only works if the hasSiblings relationship is symmetric.

#### Keys in ODL

**Key: A key for a class $C$ is a set $K$ of one or more attributes such that given any two distinct objects $o_1$ and $o_2$ in this class, $o_1$ and $o_2$ cannot have identical values for all attributes of $K$.**

A key is a constraint. Constraints define properties of objects. Constraints are part of the schema.

In ODL, we write:
```
(key (<attribute list>))
(keys (<attribute list>), … , (<attribute list>), …)
```

```
interface Star (key (name)) {
  attribute string name;
  attribute Struct Addr
    {string street, string city} address;
  relationship Set <Movie> starredIn
    inverse Movie::stars;
} ;

interface Movie (key (title, year)) {
  attribute string title;
  attribute integer year;
  attribute integer length;
  attribute enum Film 
    {color, b&w} filmType;
  relationship Set <Star> stars
    inverse Star::starredIn;
  relationship Studio ownedBy
    inverse Studio::owns;
} ;

interface Studio (keys (name),(address)) {
  attribute string name;
  attribute string address;
  relationship Set <Movie> owns
    inverse Movie::ownedBy;
  relationship MovieExec hasPres
    inverse MovieExec::isPresOf;
} ;

interface MovieExec (key (name)) {
  attribute string name;
  relationship Studio isPresOf
    inverse Studio::hasPres;
} ;
```


#### Types (in ODL)

There are seven kinds of types in ODL (analogously to Java/C++/Python, etc.):

- **Atomic** types: integer, float, character, string, boolean, Enum.

- **Interface** types: such as Movie, Star, ..., representing classes.

- **Set <T>**: an unordered collection of elements without duplicates; representing sets of elements of type T, where T is an arbitrary type.

- **Bag <T>**: unordered collections of elements with duplicates; representing bags of elements of type T, where T is an arbitrary type.

- **List <T>**: ordered elements; representing lists of elements of type T, where T is an arbitrary type.

- **Array <T,n>**: fixed length; can store elements only of the same type; representing arrays of n elements of type T, where T is an arbitrary type.

- **Struct N {T1 F1, ..., Tn Fn}**: is a type with name N, representing structures (records) with n fields F1,...,Fn, and field Fi must be atomic type Ti.

Sets, bags, lists, and arrays are called collection types.

### Entity Relationship Model (ERM)

An ERM is a graphical approach to modeling properties and relationships among sets of objects/entities.

- Entity Sets: analogous to classes in ODL; entities analogous to objects in ODL.

- Attributes: analogous to attributes in ODL except there are no data types.

- Relationships: analogous to relationships in ODL except there is one name for the relationship in both directions (in ODL Movie::stars and Star::starredIn). Relationships may involve more than two entity sets.

<div style="text-align: center;">
  <img src="image-12.png" alt="Image Description" />
</div>

#### ODL vs ERM

<div style="text-align: center;">
  <img src="image-3.png" alt="Image Description" />
</div>

#### Multiplicities of Relationships in ERM

<div style="text-align: center;">
  <img src="image-5.png" alt="Image Description" />
</div>

<div style="text-align: center;">
  <img src="image-6.png" alt="Image Description" />
</div>

##### Multiplicities in ODL vs ERM

- ODL:
```
interface Studio {
  relationship MovieExec hasPres
    inverse MovieExec::isPresOf;
} ;
interface MovieExec {
  relationship Studio isPresOf
    inverse Studio::hasPres;
} ;
```

- ERM:

<div style="text-align: center;">
  <img src="image-7.png" alt="Image Description" />
</div>

Notice the difference between the multiplicity and the arity of a
relationship.
In ODL the arity of a relationship is always binary; in ERM not necessarily.

#### Keys in ERM

**Key: key for an entity set $E$ is a set $K$ consisting of one or more attributes such that, when given any two distinct entities $e_1$ and $e_2$ in this entity set, then $e_1$ and $e_2$ cannot have identical values for all attributes of $K$.**

In ERM we can specify only one key. In ODL we can specify more than one key

An attribute can be multi-valued, i.e., the attribute can have multiple values. (e.g., a movie may have multiple languages). In ODL, no atomic attribute may have multiple values, would need a collection type instead. ERM has no types.

<div style="text-align: center;">
  <img src="image-8.png" alt="Image Description" />
</div>

*Notice "language" in 2 circlies, meaning it has multiple values.*

#### Referential Integrity

Suppose that $r$ is a relationship between $E$ and $F$. We say that $r$ fulfills the referential integrity from $E$ to $F$ if and only if $r$ has multiplicity $1..1$ with $F$. Hence, exactly one entity of $F$ is associated with an entity in $E$.

<div style="text-align: center;">
  <img src="image-9.png" alt="Image Description" />
</div>

Referential integrity can be enforced by either:

- Forbidding the deletion or update of an entity of F.
- Deleting every E entity that references a deleted F entity.
- Forbidding the insertion or update of an entity of E.

Cars must have exactly 1 owner (hence $1...1$). If $0...1$ that car can have no owner, meaning there is no referential integrity. Delete person $=>$ delete every car person owns.

<div style="text-align: center;">
  <img src="image-10.png" alt="Image Description" />
</div>

- Every movie is owned by exactly one studio.
- Every movie executive must be a president of exactly one studio.
- Every studio has at most one president (but possibly none).

In ODL, referential integrity cannot be expressed.

#### Network Model

The Network Model is an ERM where every relationship is many-one $(N:M)$.

If $r$ is a many-one $(N:1)$ relationship from $E$ to $F$, then $E$ is called the **member** and $F$ is called the **owner**.

![Alt text](image-2.png)

![Alt text](image-11.png)

#### Hierarchical Model

The Hierarchical Model is a network model that forms a forest
(i.e., a set of trees) in which the owners are the parents of the
members (there are only one-many $(1:N)$ relationships from a parent to any child).

![Alt text](image-13.png)

![Alt text](image-14.png)

#### Design Principles

- Faithfulness: close to reality as possible;
- Avoid Redundancies (same attributes in different classes);
- Simplicity

### Relational Database Model (RDM)

The main construct for representing structured data according to the Relational Data Model is
a relation. A relation consists of a relation schema and a relation instance. In relational database model, relations are defined through tables. The main component of a relation schema are typed attributes.

- **Attribute names:** Unique column names in the table
  - title
  - year
  - length
  - filmType

- **Attribute types (aka. "domains"):** Infinite sets of atomic values associated with each column
  - integer
  - float
  - character
  - string
  - {color, blackAndWhite} (remember the ODL types?)

- A **relation instance** is a finite set of (same-structured) records, also called "tuples." A **tuple** is a finite set of attribute/value pairs. Thus, from a set-oriented perspective, the order of tuples within a relation instance is not important, and also the order of attribute/value pairs within a tuple is not important.\
Example: this tuple:
```
{title:"Spectre", year:2015, length:NULL, filmType:color}
```
is the same as:
```
{length:NULL, title:"Spectre", year:2015, filmType:color}
```

| Name       | Age | Occupation  |
| ---------- | --- | ----------- |
| John Smith | 30  | Engineer    |
| Jane Doe   | 25  | Scientist   |
| Bob Brown  | 35  | Designer    |

#### Codd's 12(+1) Rules

### Rule 0: Foundation Rule
- Any (R)DBMS must be based purely on the Relational Data Model.

- Rule 1: Information Rule: Relations are tables.

- Rule 2: Guaranteed Access Rule: Every value in a table must be accessible by a combination of table name, (primary) key value, and column name.

- Rule 3: Systematic Treatment of NULL Values: NULL is distinct and incomparable to any other value.

- Rule 4: Dynamic Online Catalog Rule: Meta data describing the database schema is itself represented as relations.

- Rule 5: Comprehensive Data Sublanguage Rule: All manipulations of the (R)DBMS happen via unified (sub)languages (→SQL).

- Rule 6: View Updating Rule: All views that are theoretically updatable are also updatable by the system.

- Rule 7: High-level Insert, Update, and Delete: Changes to both base and derived relations (views) are handled in the very same way.

- Rule 8: Physical Data Independence: Applications are unimpaired by changes in the physical storage of data.

- Rule 9: Logical Data Independence: Applications are unimpaired by (information-preserving) changes in the database schema.

- Rule 10: Integrity Independence: Integrity constraints must be definable in the same (sub)language and be storable along with the meta data.

- Rule 11: Distribution Independence: A relational DBMS has distribution independence (e.g., across multiple nodes in a network).

- Rule 12: Nonsubversion(-language) Rule: If a relational system has a low-level (e.g., using a single-record-at-a-time) language (→PL/SQL), then that low-level language cannot be used to subvert or bypass the integrity rules and constraints expressed in the higher-level relational (i.e., using multiple-records-at-a-time) language.

#### Data Types

There are multiple data types:
- Numbers: INTEGER, NUMBER(p,s)
- Characted Data: CHAR(size), VARCHAR(size), CLOB(4GB-128TB)
- Dates: DATE, TIMESTAMP
- Binary Data: RAW(size), BLOB(4GB-128TB)

#### Translation of ODL Collection Types into RDM

##### Struct

```
interface Star {
  attribute string name;
  attribute Struct Addr
    {string street, string city} address;
  attribute Struct Addr born;
} ;
```

```
Star(name, address_street, address_city, born_street, born_city)
```

##### Set

```
interface Star {
  attribute string name;
  attribute Set <Struct Addr
    {string street, string city}> address;
  attribute Struct Addr born;
} ;
```

```
Star(name, address_street, address_city, born_street, born_city)
```

However, this translation can cause problems, such as **redundancy of information** and **possible lack of information**:

| name    | address_street | address_city | born_street | born_city  |
| ------- | -------------- | -----------  | ----------- | ---------- |
| Craig   | Abbey Road     | London       | Kings Street | Chester    |
| Craig   | Radley Court   | Oswestry     | Kings Street | Chester    |
| Schreck | Ahornallee     | Berlin       | NULL        | NULL       |

To solve this problem, we will use **schema** **normalization**.

##### Bag

```
interface Star {
  attribute string name;
  attribute Bag <Struct Addr
    {string street, string city}> address;
  attribute Struct Addr born;
} ;
```

| name | address_street | address_city | address_count | born_street | born_city  |
| --- | --- | ---  | --- | --- | --- |
| Craig | Abbey Road | London | 3 | Kings Street | Chester |
| Craig | Radley Court| Oswestry | 1 | Kings Street | Chester |
| Schreck | Ahornallee | Berlin | 3 | NULL | NULL |

##### List

```
interface Star {
  attribute string name;
  attribute List <Struct Addr
    {string street, string city}> address;
  attribute Struct Addr born;
} ;
```

| name | address_street | address_city | address_position | born_street | born_city  |
| --- | --- | ---  | --- | --- | --- |
| Craig | Abbey Road | London | 1 | Kings Street | Chester |
| Craig | Radley Court| Oswestry | 2 | Kings Street | Chester |
| Schreck | Ahornallee | Berlin | 1 | NULL | NULL |

##### Array

```
interface Star {
  attribute string name;
  attribute Array <Struct Addr
    {string street, string city}, 2> address;
  attribute Struct Addr born;
} ;
```

| name | address_street_1 | address_city_2 | address_street_1 | address_city_2 | born_street | born_city  |
| --- | --- | ---  | --- | --- | --- | --- |
| Craig | Abbey Road | London | Radley Court| Oswestry | Kings Street | Chester |
| Schreck | Ahornallee | Berlin | NULL | NULL | NULL | NULL |

#### Translating Relationships

```
interface Star (key (name)) {
  attribute string name;
  attribute Struct Addr
    {string street, string city} address;
  relationship Set <Movie> starredIn
    inverse Movie::stars;
};

interface Studio (keys((name),(address))) {
  attribute string name;
  attribute string address;
  relationship Set <Movie> owns
    inverse Movie::ownedBy;
}

interface Movie (key (title, year)) {
  attribute string title;
  attribute integer year;
  attribute integer length;
  attribute enum Film {color, blackAndWhite} filmType;
  relationship Set <Star> stars
    inverse Star::starredIn;
  relationship Studio ownedBy
    inverse Studio::owns;
} ;
```

Star(**name**, address_street, address_city, **starredIn_title**, **starredIn_year**)\
Movie(**title**, **year**, length, filmType, **stars_name**, ownedBy_name)\
Studio(**name**, address, **owns_title**, **owns_year**)

| name     | address_          |
|----------|-------------------|
| Craig    | Abbey Road London |
| Bellucci | Corso Venezia Milan|
| Craig    | Abbey Road London|
| Dench    | Sussex Street London|
| Schreck  | Ahornallee Berlin |

| starredIn_ | title   | year |
|------------|---------|------|
| Spectre    | 2015    | 94   |
| Spectre    | 2015    | 94   |
| Skyfall    | 2012    | 143  |
| Skyfall    | 2012    | 143  |
| Nosferatu  | 1922    | NULL |

| title   | year | length | filmType | stars_name | ownedBy_name |
|---------|------|--------|----------|------------|--------------|
| Spectre | 2015 | 94     | color    | Craig      | Pinewood     |
| Spectre | 2015 | 94     | color    | Bellucci   | Pinewood     |
| Skyfall | 2012 | 143    | color    | Craig      | Goldwyn-Mayer|
| Skyfall | 2012 | 143    | color    | Dench      | Goldwyn-Mayer|
| Nosferatu | 1922 | NULL | blackAndWhite | Schreck | Prana Film |

Problems:
- redundancy of information
- possible lack of information

#### Translation of Subclasses

There are 3 mehtods:
- E/R method
- Object-Oriented method
- NULL's method

Example:

```
interface Movie {
    attribute string title;
    attribute integer year;
    attribute integer length;
    attribute enum Film 
      {color, blackAndWhite} filmType;
    relationship Set<Star> stars 
      inverse Star::starredIn;
}

interface Cartoon : Movie {
    relationship Set<Star> voices 
      inverse Star::speaksIn;
}

interface MurderMystery : Movie {
    attribute string suspect;
}

interface CartoonMurderMystery : Cartoon, MurderMystery { }
```
- E/R method:\
Movie(title, year, length, filmType, starName)\
Cartoon(title, year, length, filmType, starName, voices)\
MurderMystery(title, year, length, filmType, starName, suspect)\
CartoonMurderMystery(title, year, length, filmType, starName, voices, suspect)

- Object-Oriented method:\
Movie(title, year, length, filmType, starName)\
Cartoon(title, year, voices)\
MurderMystery(title, year, suspect)\
CartoonMurderMystery(title, year)\
*+ key/foreign-key constraints in SQL*
![Alt text](image-15.png)

- NULL's method:\
Movie(title, year, length, filmType, starName, voices, suspect)\
*+using NULL values*

#### Functional Dependency / Multivalued Dependency

- Functional Dependency: A functional dependency (FD) on a relation schema $R$ is a statement of the form:
"If two tuples in any instance of $R$ agree on attributes $A1,A2,...,An$, then they must
also agree on another attribute $B$". Functional dependency is a concept that specifies the relationship between two sets of attributes where one attribute determines the value of another attribute. The key constraint for name in ODL implies a functional dependency (for any value $x$, do I know 1 and only 1 value $y$?): $A_1, A_2, ..., A_n \to B$ or $A_1, A_2, ..., A_n \to B_1, B_2, ..., B_m$. Function dependency maps a given set of values $A_1,...,A_n$ to a unique set of values for $B_1,...,B_n$ hence it behaves like a function.

In this table:
| title    | year | length | filmType       | starName | studioName     |
|----------|------|--------|----------------|----------|----------------|
| Spectre  | 2015 | 94     | color          | Craig    | Pinewood       |
| Spectre  | 2015 | 94     | color          | Bellucci | Pinewood       |
| Spectre  | 2015 | 94     | color          | Waltz    | Pinewood       |
| Skyfall  | 2012 | 143    | color          | Craig    | Goldwyn-Mayer  |
| Skyfall  | 2012 | 143    | color          | Dench    | Goldwyn-Mayer  |
| Nosferatu| 1922 | NULL   | blackAndWhite  | Schreck  | Prana Film     |
We have following functional dependencies:

title, year $\to$ length\
title,year $\to$ filmType\
title, year $\to$ studioN\
title,year $\to$ length,filmType\
title,year $\to$ filmType,studioN\
title,year $\to$ length,studioN\
title,year $\to$ length,filmType,studioN\
title,year,starN $\to$ length\
title,year,starN $\to$ filmType\
title,year,starN $\to$ length\
...

But not:

title $\to$ starName\
title,year $\to$ starName\
title,year $\to$ starName,length\
...

There are **Trivial** and **Non-Trivial** FD's:\
Let $X$ and $Y$ be (sub)sets of attributes of a relation schema $R$. A FD of the form $X \to Y$ is called:
1. trivial: if $Y$ is a subset of $X$.
2. non-trivial: if $Y - X$ is not empty ($Y$ has unique attributes)
3. completely non-trivial: if non-trivial, $X$ and $Y$ are disjoint (all attributes of $Y$ are unique).

$=>$ for each non-trivial FD there is exactly one equivalent completely non-trivial FD.

**Splitting Rule**: $A_1,...,A_n \to B_1,...,B_n = \{A_1,...,A_n \to B_1, A_1,...,A_n \to B_2, ..., A_1,...,A_n \to B_n\}$

**Combining Rule**: going from single $B_n$ sets to the $A_1,...,A_n \to B_1,...,B_n$

**Armstrong's Axioms**: The following three axioms allow for deriving any FD that follows from a given set of FD's (they even imply the splitting and combining rules).

1. Reflexivity:
   If $\{B1, B2, \ldots, Bm\} \subseteq \{A1, A2, \ldots, An\}$,
   then $A1, A2, \ldots, An \rightarrow B1, B2, \ldots, Bm$. (→ Definition of "trivial FD's")

2. Augmentation:
   If $A1, A2, \ldots, An \rightarrow B1, B2, \ldots, Bm$,
   then $A1, A2, \ldots, An, C1, C2, \ldots, Ck \rightarrow B1, B2, \ldots, Bm, C1, C2, \ldots, Ck$,
   for any set of attributes $C1, C2, \ldots, Ck$. (→ Definition of "non-trivial FD's")

3. Transitivity:
   If $A1, A2, \ldots, An \rightarrow B1, B2, \ldots, Bm$ and $B1, B2, \ldots, Bm \rightarrow C1, C2, \ldots, Ck$,
   then $A1, A2, \ldots, An \rightarrow C1, C2, \ldots, Ck$. (→ Searching for "keys" and "superkeys")


- Multivalued Dependency: In Multivalued functional dependency, entities of the dependent set are not dependent on each other. i.e. If $a \to \{b, c\}$ and there exists no functional dependency between $b$ and $c$, then it is called a multivalued functional dependency. The collection type for address in ODL implies a multivalued dependency:
"name $\to\to$ address_street, address_city". For example:

  | roll_no | name | age |
  | ------- | ---- | --- |
  | 42      | abc  | 17  |
  | 43      | pqr  | 18  |
  | 44      | xyz  | 18  |
  | 45      | abc  | 19  |

  Here, "roll_no $\to$ {name, age}" is a multivalued functional dependency, since the dependents name & age are not dependent on each other(i.e. "name $\to$ age" or "age $\to$ name doesn’t exist).

Thus, we can decompose the Star relation into a so-called "normal form" (here: 4NF) as follows:

Star1(**name**, **address_street**, **address_city**) and Star2(**name**, born_street, born_city)

#### Keys in RD

##### Key

A set of one or more attributes $\{A_1, ..., A_n\}$ is called a key of relation schema $R$ if:
1. It functionally determines all attributes of $R$.
2. No proper subset of the set functionally determines all attributes of $R$.

Meaning the key must be minimal set of attributes s.t. property (1) holds.

##### Superkey

A set of one or more attributes $\{A_1,...,A_n\}$ that contains a key of $R$ is called a superkey of $R$ (not minimal key).

#### Schema Normalization

| title    | year | length | filmType       | starName | studioName     |
|----------|------|--------|----------------|----------|----------------|
| Spectre  | 2015 | 94     | color          | Craig    | Pinewood       |
| Spectre  | 2015 | 94     | color          | Bellucci | Pinewood       |
| Spectre  | 2015 | 94     | color          | Waltz    | Pinewood       |
| Skyfall  | 2012 | 143    | color          | Craig    | Goldwyn-Mayer  |
| Skyfall  | 2012 | 143    | color          | Dench    | Goldwyn-Mayer  |
| Nosferatu| 1922 | NULL   | blackAndWhite  | Schreck  | Prana Film     |

This relation has:
- redundancy: length, filmType of Spectre & Skyfall are stored repeatedly
- potential inconsistencies: Spectre & Skyfall could have different length in different tuples
- update anomalies: changing the length for Spectre needs 3 updates
- deletion anomalies: deletion of Schreck as a star of Nosferatu might delete all data about Nosferatu

We could separate this table into 2 (normalize it):

Movie(**title**, **year**, length, filmType, studioName)\
StarsIn(**title**, **year**, **starName**)

| title    | year | length | filmType       | studioName     |
|----------|------|--------|----------------|----------------|
| Spectre  | 2015 | 94     | color          | Pinewood       |
| Skyfall  | 2012 | 143    | color          | Goldwyn-Mayer  |
| Nosferatu| 1922 | NULL   | blackAndWhite  | Prana Film     |

| title    | year | starName  |
|----------|------|-----------|
| Spectre  | 2015 | Craig     |
| Spectre  | 2015 | Bellucci  |
| Spectre  | 2015 | Waltz     |
| Skyfall  | 2012 | Craig     |
| Skyfall  | 2012 | Dench     |
| Nosferatu| 1922 | Schreck   |

This normalization if *full*, it is called **Boyce-Codd Normal Form** or **BCNF**.

In the following, let X be a set of attributes and Y be a single attribute of a relation
schema R, and let F be a given set of FD's over R.

- R is in First Normal Form (1NF), iff all attribute values of every tuple are atomic. All the relations we consider are in 1NF.

- R is in Second Normal Form (2NF), iff for every non-trivial FD $X \rightarrow Y$ in F
it holds that X is not a proper subset of a key of R or Y is an attribute of a key of R.

- R is in Third Normal Form (3NF), iff for every non-trivial FD $X \rightarrow Y$ in F
it holds that X is a superkey of R or Y is an attribute of a key of R.

- R is in Boyce-Codd Normal Form (BCNF), iff for every non-trivial FD $X \rightarrow Y$ in F
it holds that X is a superkey of R. Not every relation can be decomposed into BCNF
without violating the original FD's

More Intuitive Interpretation of Normal Form Definitions:
- 1NF: No collection types as attributes (no "nested" tables) allowed.
- 2NF: Do not model more than one entity set and/or N:M relationship per relation!
- 3NF: A non-key attribute may not determine any other non-key attribute.
- BCNF: A non-key attribute may not determine any other attribute (in particular
also no transitive dependencies from a non-key to a key attribute).

# Structured Query Language (SQL)

## Evaluation Order of Clauses
Evaluation order of clauses: SELECT, FROM, WHERE, GROUP BY,
HAVING, ORDER BY
- Evaluate the FROM and the WHERE clause;
- group the tuples according to the GROUP BY clause;
- select the groups according to the HAVING clause;
- produce the result according to the SELECT and the ORDER BY clause.
## CREATE TABLE
```
CREATE TABLE Movie (
  title VARCHAR(255),
  year INTEGER,
  length INTEGER,
  inColor CHAR(1),
  studioName VARCHAR(255),
  producerCertN INTEGER
);
```
## DROP TABLE
```
DROP TABLE [IF EXISTS] Movie;
```
## PRIMARY KEY
A primary key of a relation R is a set of attributes that together uniquely identify a tuple in R. Every relation schema may have at most 1 primary key.
```
CREATE TABLE MovieStar (
name CHAR(30) PRIMARY KEY,
address VARCHAR(255),
gender CHAR(1),
birthdate DATE );
```
This is only possible if the primary key contains exactly one attribute.
```
CREATE TABLE MovieStar (
  name CHAR(30),
  address VARCHAR(255),
  gender CHAR(1),
  birthdate DATE,
  PRIMARY KEY (name));
```
This allows any combination of attributes to be the primary key.
```
CREATE TABLE Movie (
  title CHAR(30),
  year INTEGER,
  length INTEGER,
  inColor CHAR(1),
  studioName CHAR(50),
  producerCertN INTEGER,
  PRIMARY KEY (title, year));
```
## UNIQUE
If, additionally, we want to express that on other projections, the relation instance may not contain duplicates, we use UNIQUE. UNIQUE may be used similarly to how PRIMARY KEY is used, but there may be more than one UNIQUE constraint per relation.
```
CREATE TABLE Movie (
  title CHAR(30),
  year INTEGER,
  length INTEGER,
  inColor CHAR(1),
  studioName CHAR(50),
  producerCertN INTEGER UNIQUE,
  PRIMARY KEY (title));
```
```
CREATE TABLE Movie (
  title CHAR(30),
  year INTEGER,
  length INTEGER,
  inColor CHAR(1),
  studioName CHAR(50),
  producerCertN INTEGER,
  PRIMARY KEY (title);
  UNIQUE(producerCertN));
```
## FOREIGN KEY
A foreign key is a set of attributes in a relation R that together uniquely identify a tuple in another relation S referenced by R. The projection of the tuples in relation R onto a foreign key may contain duplicates. The referenced attributes must be declared UNIQUE or be the PRIMARY KEY in the relation
schema of S. A relation schema may have multiple foreign keys. Each foreign-key constraint from a relation R to a relation S defines a N:1 relationship from R to S. If the set of attributes A1,...,An in R that refer to S also is a key of R, then we have a 1:1 relationship.
```
CREATE TABLE MovieExec (
  name CHAR(30) UNIQUE,
  address VARCHAR(255),
  certN INT PRIMARY KEY,
  netWorth INT);

CREATE TABLE Studio (
  CHAR(30) PRIMARY KEY, 
  address VARCHAR(255),
  presCertN INT REFERENCES MovieExec(certN));
```
This is only possible if the foreign key contains
name exactly one attribute.
```
CREATE TABLE Studio (
  CHAR(30) PRIMARY KEY,
  address VARCHAR(255),
  presCertN INT,
  FOREIGN KEY (presCertN) REFERENCES MovieExec(certN));
```
This allows any combination of attributes to be
name a foreign key.
## INDEX
An index on a set of attributes A1,...,An is a data structure that allows for efficient lookups of tuples when given a set of values for A1,...,An. Indexes by default do not assume the indexed attribute values to be unique. If, additionally, we want to express that the projection of a relation onto the indexed attributes may not contain duplicates, we may again use UNIQUE. Creating an index generally gives a trade-off between speeding up queries; slowing down insertions, deletions, updates.
```
CREATE UNIQUE INDEX MovieKeyIndex ON Movie(title,year);
DROP INDEX StudioIndex;
```
## Data Manipulation Language (DML)
### INSERT
```
INSERT INTO Movie VALUES ('Skyfall', 2012, 120, 'T', 'Fox', 123);
INSERT INTO Movie (Year, Length, InColor, StudioName, ProducerCertN, Title)
VALUES (2012, 120, 'T', 'Fox', 123, 'Skyfall');
```
### SELECT
```
SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990;

SELECT title, length
FROM Movie
WHERE studioName = 'Disney' AND year = 1990;
```
## Data Control Language (DCL)
### GRANT | REVOKE
A database administrator may grant or revoke access privileges on individual objects to individual users.
```
GRANT|REVOKE <P> ON <OBJECT> TO <USER>;
```
where P is a list of the following privileges:
```
CONNECT
SELECT
INSERT
UPDATE
REFERENCES
ALL
```
## Transaction Control Language (TCL)
Multiple subsequent DML commands issued by the same user form a transaction. The database then logs all actions performed within this transaction.
- begin - begin transaction
- commit - commit transaction
- rollback - rollback changes to the last consistent state of the database
## ORDER BY
```
ORDER BY <list of attributes>
ORDER BY (<attribute> (ASC | DESC |)) # ASC is default.

SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990
ORDER BY length, title DESC;

SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990
ORDER BY 3, 1 DESC;
```
## Comparison & Concatenation
Selection using $>,>=,<,<=,=,<>,+,-,*,/$ (using common notations for
numbers), $||$ (string concatenation), strings between $'…'$, Boolean conditions using $AND, OR, NOT, (, )$.
```
SELECT title
FROM Movie
WHERE (year > 1970 OR length < 90) AND studioName = 'MGM';
```
### LIKE | NOT LIKE
% (matches a sequence of 0 or more characters) and _ (matches one character).
```
SELECT title
FROM Movie
WHERE title LIKE 'Star ____';

SELECT title
FROM Movie
WHERE title LIKE 'Star %';
```
## NULL
Arithmetic operations ($\times,+, -, ||, ...$) with NULL return NULL. Comparisons $(>,<,=, ...)$ with NULL internally return UNKNOWN (which is however shown as FALSE in SQL).
## Joins
Joins involve more than one relation in the FROM clause.
```
SELECT name
FROM Movie, MovieExec
WHERE title = 'Star Wars' AND producerCertN = certN;

SELECT MovieStar.name, MovieExec.name
FROM MovieStar, MovieExec
WHERE MovieStar.address = MovieExec.address;
```
### Self Join
```
SELECT Star1.name, Star2.name
FROM MovieStar AS Star1, MovieStar AS Star2
WHERE Star1.address = Star2.address;
```
Star1 and Star2 are so-called tuple variables. However, if we select all pairs of stars (a,b) then we also get (b,a), (a,a) and (b,b). We solve this problem by:
```
SELECT Star1.name, Star2.name
FROM MovieStar Star1, MovieStar Star2
WHERE Star1.address = Star2.address AND Star1.name < Star2.name;
```
## UNION, INTERSECT, EXCEPT
```
SELECT title, year FROM Movie
  UNION
SELECT movieTitle AS title, movieYear AS year FROM StarsIn;

SELECT name, address
FROM MovieStar
WHERE gender = 'F'
  INTERSECT
SELECT name, address
FROM MovieExec
WHERE netWorth > 1000000;

SELECT name, address FROM MovieStar
  EXCEPT
SELECT name, address FROM MovieExec;
```
## DISTINCT
In order to eliminate duplicates in SQL, we may use DISTINCT.
```
SELECT DISTINCT name
FROM MovieExec, Movie, StarsIn
WHERE certN = ProducerCertN AND
  title = movieTitle AND
  year = movieYear AND
  starName = 'Harrison Ford';
```
## LIMIT
```
SELECT name
FROM MovieExec
WHERE certN =
  (SELECT producerCertN
  FROM Movie
  WHERE title = 'Star Wars' AND year = 1997 LIMIT 1);
```
## Connecting Subqueries
- EXISTS ( R ) iff relation R is not empty
- s IN ( R ) iff s is in relation R, detects the membership in a bag
- s NOT IN ( R ) iff s is not in relation R
- s <> ALL ( R ) iff s <> all tuples in R (=)
- s = ANY ( R ) iff s = a tuple in R (<>)
- s > ALL ( R ) iff s is greater than all the values in the relation R (<, <=, >=, =, <>)
- s > ANY ( R ) iff s is greater than at least one value in the relation R (<, <=, >=, =, <>)
- NOT EXISTS ( R ) , NOT s > ALL ( R ) , NOT s > ANY ( R )
```
SELECT title, year
FROM Movie AS OldMovie
WHERE (title, year) < ANY
  (SELECT title, year
  FROM Movie
  WHERE title = OldMovie.title);
```
## Aggregations | MIN, MAX, COUNT, SUM, AVG
```
SELECT AVG(netWorth)
FROM MovieExec;

SELECT COUNT(DISTINCT name)
FROM MovieExec;
```
## Grouping | GROUP BY
First group all the tuples per studio name, then calculate the sum for each group and create a tuple in the result for each group.
```
SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName;
```
If there is an aggregation in the SELECT clause, then the unaggregated attributes in the SELECT clause must appear in the GROUP BY clause (*studioName*).

Selection in WHERE is prior to grouping.
```
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerCertN = certN
GROUP BY name;
```
Selection in HAVING is after grouping. Each unaggregated attribute in the HAVING clause must appear in the GROUP BY clause.
```
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerCertN = certN AND netWorth >= 1000000
GROUP BY name
HAVING MIN(year) < 1930;
```
