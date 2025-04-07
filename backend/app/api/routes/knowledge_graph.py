from fastapi import APIRouter, Depends, HTTPException
from typing import List, Dict, Any
from neo4j import GraphDatabase
from app.db.neo4j.session import get_neo4j_driver
from app.models.concept import Concept

router = APIRouter()

@router.get("/", response_model=Dict[str, Any])
async def get_knowledge_graph(
    driver = Depends(get_neo4j_driver)
):
    """
    Отримує повну структуру графа знань.
    """
    nodes_query = """
    MATCH (c:Concept)
    RETURN c.id as id, c.name as name, c.description as description, 
           c.difficulty as difficulty, c.importance as importance,
           c.topic as topic
    """
    
    edges_query = """
    MATCH (c1:Concept)-[:REQUIRES]->(c2:Concept)
    RETURN c1.id as source, c2.id as target
    """
    
    with driver.session() as session:
        nodes = session.run(nodes_query).data()
        edges = session.run(edges_query).data()
    
    return {
        "nodes": nodes,
        "edges": edges
    }

@router.get("/concepts", response_model=List[Concept])
async def get_all_concepts(
    driver = Depends(get_neo4j_driver)
):
    """
    Отримує список всіх концепцій.
    """
    query = """
    MATCH (c:Concept)
    RETURN c.id as id, c.name as name, c.description as description, 
           c.difficulty as difficulty, c.importance as importance,
           c.topic as topic
    ORDER BY c.topic, c.difficulty
    """
    
    with driver.session() as session:
        result = session.run(query)
        concepts = [dict(record) for record in result]
    
    return concepts