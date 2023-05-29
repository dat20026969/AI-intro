import numpy as np
from queue import PriorityQueue

def DFS(matrix, start, end):
    paths = []
    visited = {}
    border = []
    stacks=[]
    border.append(start)
    n_vertice = matrix.shape[0]
    previousNode = start
    while border:
        presentNode = border.pop()

        if presentNode not in visited:
            visited[presentNode] =previousNode
            path.append(presentNode)

        if(presentNode == end):
            break
        
        for neighbour in range(n_vertice-1,-1,-1):
            if neighbour not in visited and matrix[presentNode][neighbour] != 0:
                border.append(neighbour)
        previousNode = presentNode
    
    stacks.append(end)
    while True:
        if stacks[-1] == start:
            break
        stacks.append(visited[stacks[-1]])
    paths = stacks
    paths.reverse()

    return visited, paths
    # TODO: 
   
    path=[]
    visited={}

    return visited, path

def BFS(matrix, start, end):
    # TODO:     
    path=[]
    visited={}
    queue=Queue1()
    queue.put((start, None))
    visited[start]=None

    parent=dict()
    parent[start]=None

    foundingPath=False
    while not queue.empty():
        presentNode, previousNode=queue.get()

        if presentNode not in visited:
            parent[presentNode]=previousNode
            visited[presentNode]=previousNode

        if presentNode==end:
            foundingPath=True
            break

        for nextNode in range(len(matrix[presentNode])):
            if nextNode not in visited and matrix[presentNode][nextNode]!=0:
                queue.put((nextNode, presentNode))

    path=[]
    if foundingPath:
        path.append(end)
        while parent[end]is not None:
            path.append(parent[end])
            end=parent[end]
        path.reverse()
   
    return visited, path


def UCS(matrix, start, end):
    # TODO:  
    path=[]
    visited={}
    exploringSet=[0,0,0,0,0,0,0,0]
    a=0
    while a<len(matrix):
        a+=1
    path.append(start)
    node=start
    exploringSet[node]=1
    presentCost=0.0
    while (node!=end):
        x_matrix=matrix[node]
        a=0
        while a<len(x_matrix):
            if(x_matrix[a]!=0 and x_matrix[a]+presentCost<visited[a]and exploringSet[a]!=1):
                visited[a]=node
            a+=1
        minimumIndex=0
        minimumValue=100
        a=0
        while a<len(x_matrix):
            if(exploringSet[a]==0):
                if(minimumValue>=x_matrix[a] and x_matrix[a]!=0):
                    minimumIndex=a
                    minimumValue=x_matrix[a]
            a+=1
        node=minimumIndex
        path.append(node)
        exploringSet[node]=1
    newVisited={}
    a=0
    while a<len(visited):
        if(visited[a]!=100):
            newVisited[a]=visited[a]
        a+=1
    visited=newVisited
    print("exploring Set: ")
    print(exploringSet)
    print("path: ")
    print(path)
    print("visited: ")
    print(visited)
            
    return visited, path


def GBFS(matrix, start, end):
    # TODO: 
    path=[]
    visited={}
    a=matrix.shape[0]
    frontier1=[start]
    frontier2={start:start}
    while frontier1:
        theBest=0
        for x in range(len(frontier1)):
            if matrix[frontier1[x]][end]<matrix[frontier1[theBest]][end]:
                theBest=x
        present=frontier1[theBest]
        frontier1.pop(best)
        if present not in visited:
            visited[present]=frontier2[present]
            frontier2.pop(present)
        if present==end:
            break
        for i in range (n-1,-1,-1):
            if i not in visited and matrix[present][i]>0:
                frontier1.insert(0,i)
                frontier2[i]=present
    path.append(end)
    while True:
        path.append(visited[path[-1]])
        if path[-1]==start:
            break
    path.reverse()
    return visited, path

def Astar(matrix, start, end, pos):
    # TODO: 
    path=[]
    visited={}
    distances = {node:float('inf') for node in matrix}
    distances[start] = 0
    visited = set()

    pq = PriorityQueue()
    pq.put((0 + pos[start], start))

    while not pq.empty():
        _, node = pq.get()
        print(node)
        if node == end:
            break
        for neighbour, distance in matrix[node]:
            if neighbour not in visited:
                old_distance = distances[neighbour]
                new_distance = distances[node] + distance
                if new_distance < old_distance:
                    distances[neighbour] = new_distance
                    priority = new_distance + pos[neighbour] 
                    pq.put((priority, neighbour))
        visited.add(node)
    return visited, path

