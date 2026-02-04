# 🎓 University Management System: Database Architecture

This repository showcases a structured approach to designing a relational database for a university system. The project focuses on core architectural integrity, establishing clear relationships between entities like Faculties, Departments, Teachers, and Groups.

## 🧠 Project Philosophy & Methodology
As part of my professional growth in SQL, I have adopted a **"Structure-First"** learning strategy.

> **Note on Methodology:**
> In this phase, I intentionally prioritized **Database Normalization** and **Referential Integrity** (Primary & Foreign Keys). I chose to master the schema design before implementing complex `JOIN` operations. This ensures that the data foundation is solid, scalable, and follows industry-standard naming conventions.

## 🖼️ Database Schema Diagram
The following diagram illustrates the relational structure of the system, including table relationships and data constraints.

![University Schema Diagram](./senin_faylinin_adi.png)

## 🛠️ Technical Highlights
- **Relational Integrity:** Implemented through Foreign Key constraints across 9 interconnected tables.
- **Data Validation:** Used `CHECK` constraints (e.g., Salary > 0, Year between 1-5) to ensure data quality.
- **Normalization:** Applied 1NF, 2NF, and 3NF principles to eliminate data redundancy.

## 📈 Progressive Roadmap
- [x] **Phase 1:** Relational Schema Design & Normalization (Current)
- [ ] **Phase 2:** Advanced Querying (Complex Multi-table Joins, CTEs, Subqueries)
- [ ] **Phase 3:** Performance Optimization (Indexing, Stored Procedures, Views)

---
*“First, solve the problem. Then, write the code.” – This project represents the architectural solution to university data management.*
