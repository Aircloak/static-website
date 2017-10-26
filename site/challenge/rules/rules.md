## Basic Rules

By way of terminology, a *participant* is the person participating in the challenge.  The participant plays the role of an *attacker,* who tries to obtain individual information from the database through a series of malicious queries.

The participant is provided with:

- Login access to an Aircloak Insights system (API and web)
- A basic description of Aircloak’s anonymization mechanisms (called Diffix)
- The full contents of the datasets being protected by Aircloak. (Aircloak provides 5 such datasets by default.  The participant may provide their own datasets for attack.)
- A list of known resolved attacks
- A discussion forum open to all attackers
- One or more samples of attack source code

The participant, acting as an attacker, may make an unlimited number of queries to Aircloak Insights.  (Limited of course by the computing capacity of Aircloak Insights.)  Using the answers, the attacker makes “claims” about the data of individuals in the dataset (see below for details). To the extent the claims are correct, the attacker may be paid a bounty. To receive a bounty, the participant must implement the attack and supply the attack code to Aircloak. Aircloak will independently validate the attack.

### Duplicate Attacks

Aircloak does not pay for duplicate attacks. To receive a bounty, the participant must satisfy the following two criteria:

1. The participant must establish *bounty rights* for a given attack
2. The attack must supply attack code that is validated by Aircloak

First *bounty precedence* goes to the first participant to adequately describe the attack to Aircloak. The description must be detailed enough that a third party could implement that attack given the description. Second bounty precedence goes to the second participant to describe the same attack, and so on. *Bounty rights* initially goes to the participant with first bounty precedence.

Upon receiving bounty rights, the participant must submit the attack code within two calendar months. If the participant fails to do so, then bounty rights are assigned to the participant with the next bounty precedence, and so on.

Aircloak reserves the right to determine what constitutes a duplicate attack.  A given attack A may imply a class of closely related attacks A’, A’’ etc. For instance, suppose there is an attack that uses a certain condition clause, and that the condition may appear in a WHERE clause with or without a sub-query, or in a HAVING clause. These variants would all be considered a single attack, not multiple attacks, and accordingly would get a single bounty. In addition, if an attack A’ is defended against by the solution to attack A, then attack A’ may likely be considered to be in the same class as attack A, and therefore a duplicate. Having said that, Aircloak will work in good faith to resolve any dispute with the participant regarding duplication of attack.

The participant agrees not to publicly disclose the attack until Aircloak has had the opportunity to implement and deploy a defense.  The participant allows Aircloak a maximum of 12 months to implement a defense.

Before spending significant time on an attack idea, the participant should of course look at the list of known resolved attacks. If the attack does not appear there, the participant is strongly encouraged to discuss the attack with Aircloak to establish bounty precedence, determine if another participant is already working on the attack, or to determine if there is an obvious flaw in the participant’s idea.

A total of $15000 is allocated by Aircloak for the challenge. Bounties will be paid in order of submitted working implementations. If not enough money remains in the budget to pay a full bounty, then only the remaining budget will be paid.

### Response Times

Aircloak will make every effort to satisfy the following response times:

- Time from submission of attack description to response (i.e. assignment of bounty precedence, indication that the attack is known resolved or unlikely to work, etc): **3 business days**
- Time from attack code submission to attack validation: **20 business days**
- Time from attack validation to bounty payment: **20 business days**

### Attacks and Bounties (the α,κ score)

The dataset being protected by Aircloak insights is referred to as the *protected dataset*. As mentioned above, the participant is given a complete copy of the protected dataset. The purpose of the copy is so that the participate may determine the effectiveness of any given attack.

The *attacker* (i.e. the participant in the role of attacker) of course does not have access to the dataset copy. The attacker may, however, have partial knowledge of the protected dataset. We refer to this as *prior knowledge*, and use it to emulate knowledge that the attacker may have obtained through external means. Many real attacks exploit prior knowledge.

The GDPR criteria for anonymity is defined according to the EU Article 29 Data Protection Working Party Opinion 05/2014 on Anonymisation Techniques (https://cnpd.public.lu/fr/publications/groupe-art29/wp216_en.pdf). This opinion defines three criteria, or risk factors, *singling-out*, *linkability*, and *inference*. The Aircloak challenge tests for all three of these risk factors.

Singling out, in the context of Aircloak Insights, occurs whenever an attacker can determine, with high confidence, that there is a single user with one or more given attributes. For instance, the attacker may claim that there is a single user with attributes [gender = ‘male’, age = 48, zipcode = 48828, lastname = ‘Ng’]. If this is true, then the attacker has successfully singled out that user.  The attributes don’t need to be personal attributes as in this example.  If the attacker correctly claims that there is a single person with the attributes [long = 44.4401, lat = 7.7491, time = ’2016-11-28 17:14:22’], then that person is singled out.

Inference is similar to singling out, but it assumes that the attacker has prior knowledge of one or more attributes for a given user, and that additional (unknown) attributes are inferred from the known attributes. For instance, in the previous example, the attacker might have prior knowledge that there are one or more users with attributes [gender = ‘male’, age = 48, lastname = ‘Ng’]. Assuming that the attacker does not have prior knowledge of the zip code, the goal of the attacker then is to make a claim about the value of the zip code where there is a single user with for instance attributes [gender = ‘male’, age = 48, zipcode = 48828, lastname = ‘Ng’]. In other words, the attacker needs to demonstrate that they can infer something new about the user from the attack.

For the challenge, we effectively treat singling out and inference as the same thing, with the distinction that singling out does not necessarily require prior knowledge, and inference does.

To test linkability, in the context of Aircloak Insights, we require a second dataset (*the linkability dataset*) which is linked with the protected dataset. The linkability dataset shares some fraction of rows and columns with the protected dataset. Linkability, in the context of Aircloak Insights, occurs whenever an attacker can determine, with high confidence, that a row or set of rows in the linkability dataset exists in the protected dataset. The linkability dataset therefore is a form of prior knowledge.

*Confidence* is a measure of the likelihood that an attacker’s claim is correct. If 95% of an attacker’s claims are correct, then the confidence of the attack is 95%. *Confidence improvement* (or just *improvement* for short) is the improvement in the attacker’s confidence over a statistical guess. By way of example for an inference attack, suppose that 90% of the users in the database have zipcode = 48828 (which the attacker can learn directly from a query of the cloak). If the attacker knows through prior knowledge that there is a single user with attributes [gender = ‘male’, age = 48, lastname = ‘Ng’], then the attacker can simply guess that this user’s zipcode = 48828, and the attacker would be correct 90% of the time. If in an attack, the attacker gives a correct zipcode 90% of the time, then the attacker has not improved over a statistical guess. However, if the attacker correctly claims that zipcode = 48828 95% of the time, then the attacker has improved over a statistical guess. We measure improvement κ as `κ = 100*(C-S)/(100-S)`, where `C` is the attacker’s confidence, and `S` is the statistical probability. In the previous example, the attacker’s improvement is `50%` (`100*(95-90)/(100-90) =` `100``*5/10 = 50`).


> Note that the Article 29 definition of inference does not include the notion of confidence improvement, rather only of confidence. However, the purpose of the inference risk is in large part to capture an attack on K-anonymity, whereby simply knowing which k-anonymity group a user belongs to can reveal additional attributes with 100% certainty. Given that the whole purpose of a database system, even an anonymized one, is to give analysts statistical knowledge, we believe that confidence improvement is the appropriate metric for inference.

We measure the amount of prior knowledge P as the number of cell values known to the attacker. If the attacker knows all values for a given database column, and there are 5 million rows, then the attacker knows 5M cell values, and P=5M. If the attacker knows 5 attributes each for 500 users, then the attacker knows 2500 cells in total, and P=2500.

For singling out and inference attacks, any attribute (cell) values claimed in the attack that are not known prior are *learned cell values*. For these attacks, we measure the amount learned L as the number of learned cells. For example, suppose that the attacker singles out 500 users, and learns two new cell values in each singling out. Then L=1000.

For linkability attacks, the attacker learns that a known row in the linkability dataset exists in the protected dataset. We measure the amount learned L as the number of rows claimed to exist in the protected dataset. If an attacker claims to link 500 rows, then L=500.

Every attack has an *effectiveness* score α. Clearly an attack is relatively more effective if less prior knowledge is required to carry out the attack. An attack is also relatively more effective if more cells are learned, or more rows are linked. We measure effectiveness α as `α=L/(P+1)`.

Bounties are based on a combination of effectiveness α and confidence improvement κ (the α,κ score). The highest bounty is $5000, and the lowest is $100. Bounties are assigned according to the following table:


| From effectiveness value α | To effectiveness value α | Base Bounty |
| -------------------------- | ------------------------ | ------------ |
| anything > 0               | 10^-11                   | $500         |
| 10^-11                     | 10^-10                   | $600         |
| 10^-10                     | 10^-9                    | $700         |
| 10^-9                      | 10^-8                    | $800         |
| 10^-8                      | 10^-7                    | $900         |
| 10^-7                      | 10^-6                    | $1000        |
| 10^-6                      | 10^-5                    | $1500        |
| 10^-5                      | 10^-4                    | $2000        |
| …                          | …                        | …            |
| 0.1                        | 1                        | $4000        |
| 1                          | 10                       | $4500        |
| 10                         | anything > 10            | $5000        |


The base bounty is the bounty awarded if the confidence improvement is 95% or better. If the improvement is less than 95%, then the base bounty is multiplied by a factor `F` selected according to the following table:

| Confidence Improvement κ | Factor F |
| ------------------------ | -------- |
| 95% - 100%               | 1        |
| 90% - 95%                | 0.9      |
| 80% - 90%                | 0.6      |
| 70% - 80%                | 0.3      |
| 50% - 70%                | 0.1      |
| 0% - 50%                 | 0        |

If the factor `F` results in a bounty lower than $100, then the bounty is set at $100.  In other words, $100 is the minimum bounty for any attack that achieves a non-zero bounty.


### Datasets

Aircloak provides five datasets for the Aircloak Challenge.  The datasets differ substantially in content, and so represent a wide variety of dataset types.  They are described at the end of this document.

For singling out and inference attacks, the full dataset is used as the protected dataset. For linkability attacks, two additional protected datasets are provided. In one, 50% of rows are randomly removed. In the other, all rows from 50% of random users are removed.

The participant is free to provide their own dataset, *but the dataset must be a real dataset for the bounty table to apply*. The dataset must have only a single UID-type column (this is the column that identifies the individual user in the dataset).  Note also that currently we have not implemented protection for dynamic databases. The attack must take place on a static database. There may be other known restrictions on the dataset not mentioned here.

Of course, it must be legal for the dataset to be used, for instance because it is public, or because the data owners have approved the usage.  If the participant wishes to use a synthetic dataset or a small dataset, then please contact us to discuss (challenge@aircloak.com).

### Selecting Prior Knowledge

The attacker is allowed prior knowledge because it may often be the case in real life that the attacker knows certain details about the dataset, or about users in the dataset through external sources.  For instance, in 2002, Sweeney was able to attack an “anonymized” medical database using knowledge obtained in a publicly available voter registration dataset.  It may also be that an analyst has full access to a dataset that was joined with another dataset, giving them substantial knowledge about portions of the resulting dataset.

For singling out and inference attacks, it is up to the participant to determine what prior knowledge they would like to assume in the role of an attacker for any given attack. For the bounty table to apply, however, the participant cannot use direct knowledge of cell values in the dataset in determining the attacker’s prior knowledge. The attacker may, however, use knowledge learned from queries to the database made via Aircloak.

Following are a few examples of how a participant may select prior knowledge without exploiting direct knowledge of the contents of the dataset:

- Select one or more columns (a *column group*). Select some number of random rows, and define the cells in those rows for the column group to be prior knowledge. The number of random rows can be a fraction of all rows (e.g. 50%), or an absolute number (5000 rows, or all but 5000 rows).
- Select a column group. Select some number of random users for which all column values for those users are prior knowledge.
- Select a column group.  Select all rows (or all users) where some column has a certain value.
- Some combination of the above.  For instance, select all columns for 50% of the users. Additionally select from the remaining 5000 rows where lastname, age, and marital_status are known.

If the participant is unsure as to whether their method of defining prior knowledge is acceptable, please contact us at challenge@aircloak.com.  If the participant has an attack in mind that does require very specific prior knowledge based on knowledge of the dataset, please contact us to discuss.  We would be interested in understanding such attacks even if they won’t exist in practice, and may agree on some bounty.


### Establishing Confidence and Improvement

Confidence is a measured statistical property: the attacker generates a series of singling out claims, and each claim is either correct or incorrect.  The confidence `C` for the attack is the number of correct claims divided by the total number of claims (`C=correct/total`).

As stated already, confidence improvement is defined as `100*(C-S)/(100-S)`, where `C` is the attacker’s confidence.

For singling out or inference attacks,  `S` is the statistical probability of a value or set of values. `S` is computed as the average statistical probability across all claims. In other words, `S=sum(S_i)/N`, where `S_i` is the statistical probability of claim `i`, and `N` is the number of claims. `S_i` for any given claim is computed as `S_i=C_i/R`, where  `C_i` is the count of the number of rows that match all of the unknown claim conditions, and `R` is the total number of rows.

To give an example, suppose that the attacker knows [gender = ‘male’, age = 48, lastname = ‘Ng’], and makes a claim [gender = ‘male’, age = 48, lastname = ‘Ng’, zipcode = 12345, firstname = ‘Bao’]. `C_i` then is the number of rows where [zipcode = 12345, firstname = ‘Bao’].

Note that the statistical probability here is derived from all claims, not only those where the attacker happens to be correct.

For linkability attacks, `S = 50`, the probability that a given row exists in the protected dataset.

To get a reasonably accurate confidence value, we require at least 200 claims.  If the participant cannot for some reason produce 200 claims, but can argue that the attack confidence is never-the-less high, then please contact us to discuss what a fair bounty should be.

If a single attack (i.e. an instance of an attack with a given dataset and assumed prior knowledge) cannot produce 200 claims, then the attacker may need to replicate the attack with different starting conditions (different prior knowledge or dataset).  For instance, if the attack requires prior knowledge of all cells but one, then the attack cannot make more than one claim (on the single unknown cell).  Such an attack would have to be replicated 200 times with a different unknown cell each time.

It may be possible in some cases that the attacker knows that certain claims are more likely to be correct than certain other claims. In these cases, the attacker may choose not to make claims on those that would otherwise be low confidence.  For instance, suppose that the attacker uses three complete columns as prior knowledge on a dataset with 1M rows (so P=3M). Suppose that of the millions of possible claims the attacker could make, the attacker knows that 500 of them are likely to be high-confidence claims. The attacker then only needs to make those 500 claims.  Supposing that all of them are correct, then L=500, confidence C=100%, and improvement κ=100%.  Note however that in computing effectiveness α, we still use the full prior knowledge of P=3M.
