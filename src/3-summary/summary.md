# Summary

Calling OpenAI & LangChain to summrise given transcript or subtitle

## Ask Claude.AI to compare 2 approaches

From a reader's perspective, summary #1 (refine algorithm) is generally better. It offers a more comprehensive, detailed, and context-rich overview of the podcast. This summary would be particularly useful for readers who want a thorough understanding of the discussion or who might be using the summary as a reference.

However, summary #2 (map reduce algorithm) might be preferred by readers looking for a quicker, more concise overview of the main points. Its brevity could be an advantage for those who want just the key takeaways without diving into too much detail.

For a general audience seeking a comprehensive understanding of the podcast, summary #1 would be the better option.

## Ask Claude.AI to compare refine algorithm to Google NotebookLM


## Final Conclusion


To implement the MapReduceDocumentsChain in a Jupyter Notebook, you can follow these steps:
Setup
First, import the necessary libraries and initialize the LLM:
python
from langchain.chat_models import ChatOpenAI
from langchain.chains import MapReduceDocumentsChain, ReduceDocumentsChain
from langchain.chains.combine_documents.stuff import StuffDocumentsChain
from langchain.chains.llm import LLMChain
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.documents import Document

# Initialize the LLM
llm = ChatOpenAI(temperature=0)

Map Step
Create the map chain:
python
map_template = "Write a concise summary of the following: {docs}"
map_prompt = ChatPromptTemplate.from_template(map_template)
map_chain = LLMChain(llm=llm, prompt=map_prompt)

Reduce Step
Create the reduce chain:
python
reduce_template = """
The following is a set of summaries:
{docs}
Take these and distill them into a final, consolidated summary of the main themes.
"""
reduce_prompt = ChatPromptTemplate.from_template(reduce_template)
reduce_chain = LLMChain(llm=llm, prompt=reduce_prompt)

Combine Documents
Create the StuffDocumentsChain:
python
combine_documents_chain = StuffDocumentsChain(
    llm_chain=reduce_chain,
    document_variable_name="docs"
)

Reduce Documents Chain
Create the ReduceDocumentsChain:
python
reduce_documents_chain = ReduceDocumentsChain(
    combine_documents_chain=combine_documents_chain,
    collapse_documents_chain=combine_documents_chain,
    token_max=4000
)

MapReduceDocumentsChain
Finally, create the MapReduceDocumentsChain:
python
map_reduce_chain = MapReduceDocumentsChain(
    llm_chain=map_chain,
    reduce_documents_chain=reduce_documents_chain,
    document_variable_name="docs",
    return_intermediate_steps=False
)

Usage
Now you can use the MapReduceDocumentsChain to process your documents:
python
# Example documents
documents = [
    Document(page_content="Apples are red", metadata={"title": "apple_book"}),
    Document(page_content="Blueberries are blue", metadata={"title": "blueberry_book"}),
    Document(page_content="Bananas are yellow", metadata={"title": "banana_book"}),
]

# Run the chain
result = map_reduce_chain.run(documents)
print(result)

This implementation will process the documents using the map-reduce strategy:
The map step summarizes each document individually.
The reduce step combines these summaries into a final summary.
For longer documents, the reduce step will recursively "collapse" the summaries until the total length is within the specified token limit (4000 in this example).
Remember to handle your API keys securely when working with OpenAI or other LLM providers in a Jupyter Notebook. You may want to use environment variables or a secure method to input your API key rather than hardcoding it.