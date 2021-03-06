/*
 * @(#)SiadapSuggestionBean.java
 *
 * Copyright 2012 Instituto Superior Tecnico
 * Founding Authors: Paulo Abrantes
 * 
 *      https://fenix-ashes.ist.utl.pt/
 * 
 *   This file is part of the SIADAP Module.
 *
 *   The SIADAP Module is free software: you can
 *   redistribute it and/or modify it under the terms of the GNU Lesser General
 *   Public License as published by the Free Software Foundation, either version 
 *   3 of the License, or (at your option) any later version.
 *
 *   The SIADAP Module is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public License
 *   along with the SIADAP Module. If not, see <http://www.gnu.org/licenses/>.
 * 
 */
package module.siadap.domain.wrappers;

import java.io.Serializable;
import java.util.Comparator;

import module.organization.domain.Person;
import module.organization.domain.Unit;
import module.siadap.domain.ExceedingQuotaProposal;
import module.siadap.domain.ExceedingQuotaSuggestionType;
import module.siadap.domain.SiadapUniverse;
import module.siadap.domain.exceptions.SiadapException;

/**
 * 
 * @author João Antunes
 * 
 */
public class SiadapSuggestionBean implements Serializable {

    public static final Comparator<SiadapSuggestionBean> COMPARATOR_BY_PRIORITY_NUMBER = new Comparator<SiadapSuggestionBean>() {

        @Override
        public int compare(SiadapSuggestionBean o1, SiadapSuggestionBean o2) {
            if (o1 == null && o2 == null) {
                return 0;
            }
            if (o1 == null && o2 != null) {
                return -1;
            }
            if (o1 != null && o2 == null) {
                return 1;
            }
            Integer priorityNumber1 = o1.getExceedingQuotaPriorityNumber();
            Integer priorityNumber2 = o2.getExceedingQuotaPriorityNumber();
            if (priorityNumber1 == null || priorityNumber2 == null) {
                if (priorityNumber1 == null && priorityNumber2 == null) {
                    return 0;
                }
                if (priorityNumber1 == null) {
                    return -1;
                }
                if (priorityNumber2 == null) {
                    return 1;
                }
            }
            return priorityNumber1.compareTo(priorityNumber2) == 0 ? o1.getProposal().getExternalId()
                    .compareTo(o2.getProposal().getExternalId()) : priorityNumber1.compareTo(priorityNumber2);
        }
    };

    /**
     * Default serial version
     */
    private static final long serialVersionUID = 1L;

    private ExceedingQuotaSuggestionType type;

    private Integer exceedingQuotaPriorityNumber;

    private final SiadapUniverse siadapUniverse;

    private PersonSiadapWrapper personWrapper;

    private final UnitSiadapWrapper unitWrapper;

    private final Integer year;

    private final boolean withinQuotasUniverse;

    private Person autoCompletePerson;

    private ExceedingQuotaProposal proposal;

    public SiadapSuggestionBean(PersonSiadapWrapper person, UnitSiadapWrapper unitWrapper, boolean quotasUniverse,
            SiadapUniverse siadapUniverse) {
        this.setPersonWrapper(person);
        this.unitWrapper = unitWrapper;
        this.year = person.getYear();
        //init the exceedingQuotaPriorityNumber
        Unit unit = unitWrapper.getUnit();

        if (unit == null) {
            throw new SiadapException("error.illegal.use.of.SiadapSuggestionBean");
        }

        ExceedingQuotaProposal exceedingQuotaProposal =
                ExceedingQuotaProposal.getQuotaProposalFor(unit, year, person.getPerson(), siadapUniverse, quotasUniverse);
        if (exceedingQuotaProposal == null) {
            this.exceedingQuotaPriorityNumber = null;
            this.type = null;
        } else {
            this.exceedingQuotaPriorityNumber = exceedingQuotaProposal.getProposalOrder();
            this.type = exceedingQuotaProposal.getSuggestionType();
        }

        this.withinQuotasUniverse = quotasUniverse;
        this.siadapUniverse = siadapUniverse;

    }

    public SiadapSuggestionBean(ExceedingQuotaProposal proposal) {
        this.exceedingQuotaPriorityNumber = proposal.getProposalOrder();
        this.type = proposal.getSuggestionType();
        this.withinQuotasUniverse = proposal.getWithinOrganizationQuotaUniverse();
        this.personWrapper = new PersonSiadapWrapper(proposal.getSuggestion(), proposal.getYear());
        this.year = proposal.getYear();
        this.unitWrapper = new UnitSiadapWrapper(proposal.getUnit(), proposal.getYear());
        this.siadapUniverse = proposal.getSiadapUniverse();
        this.setProposal(proposal);

    }

    /**
     * Constructor for the empty SiadapSuggestionBean - used by the interface
     */
    public SiadapSuggestionBean(UnitSiadapWrapper unitWrapper) {
        this.year = unitWrapper.getYear();
        this.unitWrapper = unitWrapper;
        this.siadapUniverse = null;
        this.withinQuotasUniverse = false;
        this.personWrapper = new PersonSiadapWrapper(null, year);
    }

    public Boolean getCurrentHarmonizationAssessment() {
        return getPersonWrapper().getHarmonizationCurrentAssessmentFor(siadapUniverse);
    }

    public Boolean getCurrentHarmonizationExcellencyAssessment() {
        return getPersonWrapper().getHarmonizationCurrentExcellencyAssessmentFor(siadapUniverse);
    }

    public ExceedingQuotaSuggestionType getType() {
        return type;
    }

    public void setType(ExceedingQuotaSuggestionType type) {
        this.type = type;
    }

    public Integer getYear() {
        return year;
    }

    public Integer getExceedingQuotaPriorityNumber() {
        return exceedingQuotaPriorityNumber;
    }

    public void setExceedingQuotaPriorityNumber(Integer exceedingQuotaPriorityNumber) {
        this.exceedingQuotaPriorityNumber = exceedingQuotaPriorityNumber;
    }

    public PersonSiadapWrapper getPersonWrapper() {
        return personWrapper;
    }

    public UnitSiadapWrapper getUnitWrapper() {
        return unitWrapper;
    }

    public boolean isWithinQuotasUniverse() {
        return withinQuotasUniverse;
    }

    public void setPersonWrapper(PersonSiadapWrapper personWrapper) {
        this.personWrapper = personWrapper;
    }

    public Person getAutoCompletePerson() {
        return autoCompletePerson;
    }

    public void setAutoCompletePerson(Person autoCompletePerson) {
        this.autoCompletePerson = autoCompletePerson;
    }

    public ExceedingQuotaProposal getProposal() {
        return proposal;
    }

    public void setProposal(ExceedingQuotaProposal proposal) {
        this.proposal = proposal;
    }

}
