Forest-Fire-Tree-Composition-Model
Forest fire spread simulation model of different tree composition scenarios built with GAMA

Park et al. (2024) assessment of  forest fire damage vulnerability and forest fire resistance according to the species(bread leaf or needle leaf trees) composition of the forest stand established that:

NT species burn faster and more intensely (Park et al., 2024) 
BT species act as natural fire buffers. (Park et al., 2024) 
More BT → less spread (Park et al., 2024) 
Fire behavior emerges from local interactions, not global control. (Park et al., 2024) 
Fires in mixed NT and BT forests tend to be of lower intensity Wang (2002). BT concentration can be said to control fire intensity
BTs undergo similar fire damage to NTs in forest stands heavily dominated by NTs. (Park et al., 2024) 
NTs in forests with a higher proportion of BTs exhibit similar fire damage to BTs, despite the higher fire vulnerability of NTs. (Park et al., 2024) 


Model Rules:

Randomly assign BT/NT based on proportion.

Ignite fire in an NT tree.

NT with at least 3 BT neighbors do not burn

BT with at least 3 BT neighbors burn

BT ratio controls frie intensity. More NT, higher fire intensity, and high spread probability. 

More BT, lower fire intensity, and lower spread probability.

Track burning → burnt → alive states.

Plot dynamics over time.

References
Park, J., Moon, M., Green, T., Kang, M., Cho, S., Lim, J., & Kim, S.-J. (2024). Impact of tree species composition on fire resistance in temperate forest stands. Forest Ecology and Management, 572, 122279. 	https://doi.org/10.1016/j.foreco.2024.122279

Popović, Z., Bojović, S., Marković, M., & Cerdà, A. (2021). Tree species flammability based on plant traits: A 	synthesis. Science of The Total Environment, 800, 149625. 	https://doi.org/10.1016/j.scitotenv.2021.149625

Storey, M. A., Price, O. F., Almeida, M., Ribeiro, C., Bradstock, R. A., & Sharples, J. J. (2021). Experiments on the influence of spot fire and topography interaction on fire rate of spread. PLOS ONE, 16(1), 	e0245132. https://doi.org/10.1371/journal.pone.0245132

Wang, G. G. (2002). Fire severity in relation to canopy composition within burned boreal mixedwood stands. Forest Ecology and Management, 163(1–3), 85–92. 	https://doi.org/10.1016/S03781127(01)00529-1
