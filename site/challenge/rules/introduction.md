_Version 4, Oct 2017_

## Introduction

The Aircloak Challenge is a bounty program to better understand the properties of the Aircloak Insights anonymization system and its underlying anonymization technology, Diffix. Aircloak Insights is a system that sits between a database and an analyst. The database contains non-anonymized data about users. Aircloak Insights accepts SQL queries from the analyst and returns anonymized aggregate answers to the analyst.  Aircloak Insights adds noise to answers, but does so in a way that is tailored to the semantics of the SQL.  As such, Aircloak Insights operates both on the SQL and on the results returned by the back-end database.

Unlike traditional bounty programs, where attackers do penetration testing or examine source code for bugs, the Aircloak Challenge is looking for weaknesses in the design and implementation of its anonymization mechanisms. This is, to our knowledge, the first bounty program geared towards anonymization. The understanding gained from this program can lead to both stronger anonymization and to better risk assessment with respect to any weaknesses that exist in the system.

The attacker is given access to the SQL interface, and can make an unlimited number of queries to the system in an attempt to obtain information about single individual users in the database. Bounties ranging from $100 to $5000 (USD) are offered depending on how much individual user data can be learned, and on how much prior knowledge about the database is required.

We expect this challenge to be the first of multiple challenges.  This challenge starts in November 2017 and runs for 6 months or until the total allocated budget of $15,000 is exhausted.

Bounties are paid through Paypal.


## Why a Bounty Challenge?

The purpose of the Aircloak challenge is not to somehow “prove” that Diffix, and Aircloak’s implementation of it, is secure. Lack of a demonstrated attack obviously does not mean that an attack doesn’t exist. Rather the Aircloak challenge is a good-faith, best-effort attempt at finding and fixing unknown weaknesses in the technology. In an ideal world, we would use mathematical or logical proofs to convince ourselves of the strength of an anonymization scheme. However after 15 years of trying — starting with K-anonymity in 2002 through to differential privacy at present — no generally usable anonymization methodology has emerged. Both [Google’s](https://research.google.com/pubs/archive/42852.pdf) and [Apple’s](https://arxiv.org/abs/1709.02753) implementations of differential privacy, for instance, have *mathematically* unbounded privacy loss, though *in practice* almost certainly provide quite good anonymity.

Twenty years ago, crypto cracking challenges were quite common, and ultimately [shown to be of limited value](https://www.schneier.com/crypto-gram/archives/1998/1215.html#1) at best. Years of rigorous mathematical work in an open academic environment were required to produce secure crypto algorithms. By contrast, today bug bounty programs are quite common and provide tremendous value to dozens of companies. Complex systems defy mathematical proofs, so bug bounties are a reasonable if imperfect way forward. The same holds for Aircloak Insights.


## What a Program Participant Can Expect

The Aircloak challenge is a bounty program for a new and specialized technology. There may be a substantial effort involved in understanding the technology, designing attacks, and coding and executing the attacks. While there is always the possibility that a participant may quickly conceive a new killer attack, there is also every likelihood that a participant may devote several hours of background work and not come up with any new ideas. Ideally the participant is doing this out of interest in the technology, not as a means of making money. In what follows, we outline the process that a participant can expect to go through after signing up for the bounty program:


- Read this document and understand the methodology for defining successful attacks (8 pages)
- Read the document describing the anonymization technology and the kinds of attacks it defends against (20-30 pages)
- Look over the discussion forum to learn from other attackers
- Sketch out an attack
- Confirm that the attack is not on the list of known resolved attacks or already discussed on the forum
- Communicate your attack sketch with us to learn if someone else is already pursuing it, or to learn for instance why we think the attack may succeed or fail (challenge@aircloak.com)
- Write a concise description of the attack and tell us about it so that you establish *bounty rights*
- Code and execute the attack, and measure its α,κ score (*effectiveness* α and *confidence improvement* κ) to determine the bounty amount
- Convey the attack code and attack results to us for validation
