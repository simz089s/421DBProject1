-- Question 3

/**
 * 1) Index on the specialization attribute of the HealthPractitioners relation:
 * 
 * Indexing on specializations is useful for finding how frequent a specific drug is prescribed by medical specializations (e.g. cardiology).
 * Queries to find the most and least prescribed drugs are used to alter and optimize insurance plans. 
 * For example, if a new dermatology drug is released and a lot of dermatologists are prescribing it, 
 * then it should be included in the offered insurance plans.
 */

CREATE INDEX specialization_idx
        ON healthpractitioners (specialization)
;

-- DROP INDEX specialization_idx;

/**
 * 2) Index on the manufacturer attribute of the Drugs relation:
 * 
 * Indexing on manufacturer is useful to categorize manufacturers into generic drug manufacturers and brand-name drug manufacturers.
 * When the client buys a prescribed drug, the drug sold to the client by the pharmacist could be made by different manufacturers.
 * This is important to the insurance company so that different coverages can be optimized and offered to the clients. 
 * The clients also need to know about the difference in the coverage of a generic drug versus a brand-name drug.
 */

CREATE INDEX manufacturer_idx
        ON drugs (manufacturer)
;

-- DROP INDEX manufacturer_idx;

