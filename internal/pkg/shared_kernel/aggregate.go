package sharedkernel

type Aggregate struct {
	DomainEvents []DomainEvent
}

func (agg *Aggregate) ApplyDomain(event DomainEvent) {
	agg.DomainEvents = append(agg.DomainEvents, event)
}
