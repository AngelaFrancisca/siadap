/**
 * 
 */
package module.siadap.domain.util.actions;

import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.groups.Group;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.messaging.domain.Message;
import org.fenixedu.messaging.domain.Message.MessageBuilder;
import org.fenixedu.messaging.domain.MessagingSystem;
import org.fenixedu.messaging.domain.Sender;

import module.organization.domain.Person;
import module.organization.domain.Unit;
import module.siadap.domain.Siadap;
import pt.ist.fenixframework.Atomic;

/**
 * @author João Antunes (joao.antunes@tagus.ist.utl.pt) - 30 de Jan de 2013
 * 
 * 
 */
public class SiadapUtilActions {

    public static void notifyRemovalOfHarmonizationResponsible(Person person, Unit unit, int year, HttpServletRequest request) {
        // notify the users who have access to this interface
        String notificationSubject = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.managers.terminateUnitHarmonization.subject", String.valueOf(year),
                person.getName(), unit.getPresentationName());
        String notificationContent = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.managers.terminateUnitHarmonization.content", person.getName(),
                person.getUser().getUsername(), unit.getPresentationName(), unit.getAcronym());

        SiadapUtilActions.notifySiadapStructureManagementUsers(request, notificationSubject, notificationContent);

        // notify the user
        notificationSubject = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.person.terminateUnitHarmonization.subject", String.valueOf(year),
                unit.getPresentationName());

        notificationContent = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.person.terminateUnitHarmonization.content", String.valueOf(year),
                unit.getPresentationName(), unit.getAcronym());

        SiadapUtilActions.notifyUser(request, notificationSubject, notificationContent, Stream.of(person.getUser()));

    }

    public static void notifyAdditionOfHarmonizationResponsible(Person person, Unit unit, int year, HttpServletRequest request) {

        // notify the users who have access to this interface

        String notificationSubject = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.managers.addHarmonizationUnit.subject", String.valueOf(year),
                person.getUser().getUsername(), unit.getAcronym());
        String notificationContent = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.managers.addHarmonizationUnit.content", person.getName(),
                person.getUser().getUsername(), unit.getPresentationName(), unit.getAcronym());

        SiadapUtilActions.notifySiadapStructureManagementUsers(request, notificationSubject, notificationContent);

        // notify the user
        notificationSubject = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.person.addHarmonizationUnit.subject", String.valueOf(year),
                unit.getPresentationName());

        notificationContent = BundleUtil.getString(Siadap.SIADAP_BUNDLE_STRING,
                "manage.siadapStructure.notification.email.person.addHarmonizationUnit.content", String.valueOf(year),
                unit.getPresentationName(), unit.getAcronym());

        SiadapUtilActions.notifyUser(request, notificationSubject, notificationContent, Stream.of(person.getUser()));

    }

    public static void notifySiadapStructureManagementUsers(final HttpServletRequest request, String subject, String content) {
        // get the SiadapStructureManagementUsers
        int year = Integer.parseInt(request.getParameter("year"));
        Stream<User> users = Group.dynamic("SiadapStructureManagementGroup").getMembers();

        // notify them
        notifyUser(request, subject, content, users);
    }

    public static void notifyUser(HttpServletRequest request, String notificationSubject, String notificationContent,
            Stream<User> users) {
        auxNotifyUser(users, notificationSubject, notificationContent);
    }

    protected static void addMessage(final HttpServletRequest request, final String key, final String... args) {
        addMessage(request, "message", key, args);
    }

    protected static void addMessage(final HttpServletRequest request, final String property, final String key,
            final String... args) {
        final ActionMessages messages = getMessages(request);
        messages.add(property, new ActionMessage(key, args));
        saveMessages(request, messages);
    }

    // created because of the faulty dml injector
    @Atomic
    private static void auxNotifyUser(Stream<User> users, String notificationSubject, String notificationContent) {
        final Sender sender = MessagingSystem.systemSender();
        final MessageBuilder message = Message.from(sender);
        message.subject(notificationSubject);
        message.textBody(notificationContent);
        message.to(Group.users(users));
        message.send();
    }

    private static ActionMessages getMessages(HttpServletRequest request) {
        ActionMessages messages = (ActionMessages) request.getAttribute(Globals.MESSAGE_KEY);
        if (messages == null) {
            messages = new ActionMessages();
        }
        return messages;
    }

    private static void saveMessages(HttpServletRequest request, ActionMessages messages) {

        // Remove any messages attribute if none are required
        if ((messages == null) || messages.isEmpty()) {
            request.removeAttribute(Globals.MESSAGE_KEY);
            return;
        }

        // Save the messages we need
        request.setAttribute(Globals.MESSAGE_KEY, messages);
    }
}
